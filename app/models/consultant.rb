# rubocop:disable Metrics/ClassLength
class Consultant < ActiveRecord::Base
  include Searchable, Nameable, Contactable

  acts_as_messageable

  RESUME_MIME_TYPES   = ['application/pdf']
  PROFILE_IMAGE_TYPES = ['image/jpg', 'image/png', 'image/jpeg']

  paginates_per 15

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  scope :approved, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::APPROVED[:code]))
  end)
  scope :rejected, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::REJECTED[:code]))
  end)
  scope :pending_approval, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::PENDING_APPROVAL[:code]))
  end)
  scope :on_hold,
        ->() { where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::ON_HOLD[:code])) }
  scope :in_progress, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::IN_PROGRESS[:code]))
  end)
  scope :approve_reject, (lambda do
    where(arel_table[:approved_status_id].eq(ApprovedStatus.pending_approval.id)
            .or(arel_table[:approved_status_id].eq(ApprovedStatus.on_hold.id)))
  end)
  scope :recent, (lambda do
    approved.limit(3).order(created_at: :desc)
  end)

  before_create :skip_confirmation!, if: -> { Rails.env.staging? }
  before_create :set_approved_status
  after_commit :update_consultant_index, on: [:update]
  after_commit :destroy_consultant_index, on: [:destroy]

  mount_uploader :resume, ResumeUploader, mount_on: :resume_file_name
  mount_uploader :profile_image, ProfileImageUploader, mount_on: :profile_image_file_name

  has_one :address, dependent: :destroy
  has_one :military, dependent: :destroy
  has_one :background, dependent: :destroy
  belongs_to :approved_status
  has_many :shared_contacts, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :project_histories, dependent: :destroy
  has_many :project_history_positions, through: :project_histories
  has_many :positions, through: :project_history_positions
  has_many :consultant_skills, dependent: :destroy
  has_many :skills, through: :consultant_skills
  has_many :consultant_certifications, dependent: :destroy
  has_many :certifications, through: :consultant_certifications
  has_many :educations, dependent: :destroy
  has_many :projects, ->() { order(updated_at: :desc) }, dependent: :destroy

  accepts_nested_attributes_for :educations, allow_destroy: true

  REPORT_COLUMN_NAMES = {
    'street_address' => 'Consultant Address',
    'status'         => 'Consultant Account Status',
    'sign_in_count'  => '# of Consultant Log-Ins',
    'rate'           => 'Hourly Rate'
  }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      # Add the header row
      csv << export_columns.map do |raw_column|
        REPORT_COLUMN_NAMES[raw_column] || raw_column.humanize.titleize
      end

      all.order(:first_name).each do |consultant|
        values = export_columns.map do |col|
          if col =~ /_project_/
            consultant.project_history_info for_column: col
          else
            consultant.send(col)
          end
        end
        csv << values
      end
    end
  end

  def project_history_info(for_column:)
    for_column =~ /^(\d).._project_(.+)$/
    number =    Regexp.last_match(1).to_i
    attribute = Regexp.last_match(2)
    history =   project_histories[number - 1]
    return '' unless history.present?

    case attribute
    when 'positions'
      history.positions.pluck(:label).join(', ')
    when 'poc_name'
      history.client_poc_name
    when 'poc_email'
      history.client_poc_email
    when 'poc_phone'
      history.phone.try(:number)
    end
  end

  def street_address
    address.try(:address)
  end

  def primary_phone
    phones.size > 0 ? phones.first.number : ''
  end

  def date_account_created
    created_at
  end

  def date_last_signed_in
    last_sign_in_at
  end

  def date_modified
    updated_at
  end

  def status
    approved_status.label
  end

  def mailboxer_email(_object)
    email
  end

  def approved?
    approved_status.code == ApprovedStatus::APPROVED[:code]
  end

  def rejected?
    approved_status.code == ApprovedStatus::REJECTED[:code]
  end

  def pending_approval?
    approved_status.code == ApprovedStatus::PENDING_APPROVAL[:code]
  end

  def on_hold?
    approved_status.code == ApprovedStatus::ON_HOLD[:code]
  end

  def in_progress?
    approved_status.code == ApprovedStatus::IN_PROGRESS[:code]
  end

  def skills_list
    skills.pluck(:code).join(', ')
  end

  def skills_list=(skills)
    self.skills = skills.split(',').map do |n|
      Skill.where(code: n.downcase.strip).first_or_create!
    end
  end

  def certifications_list
    certifications.pluck(:label).join(', ')
  end

  def certifications_list=(certifications)
    self.certifications = certifications.split(',').map do |n|
      Certification.find(n)
    end
  end

  private

  def destroy_consultant_index
    __elasticsearch__.delete_document
  end

  def update_consultant_index
    if approved?
      ConsultantIndexer.perform_async(:update, id)
    elsif rejected? && previous_changes.key?(:approved_status_id)
      ConsultantIndexer.perform_async(:destroy, id)
    end
  end

  def set_approved_status
    self.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::IN_PROGRESS[:code])
  end

  def self.export_columns
    %w(
      first_name last_name primary_phone email street_address status
      date_account_created date_pending_approval date_approved
      date_on_hold date_rejected date_last_signed_in
      date_modified sign_in_count rate
    ) + dynamic_export_columns
  end

  def self.dynamic_export_columns
    %w( 1st 2nd 3rd )
      .product(%w( positions poc_name poc_email poc_phone ))
      .map { |prefix, suffix| "#{prefix}_project_#{suffix}" }
  end
end
