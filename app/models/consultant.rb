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

  def self.to_csv
    columns = %w(
      first_name
      last_name
      primary_phone
      email
      date_account_created
      date_pending_approval
      date_approved
      )
    CSV.generate do |csv|
      csv << columns
      all.each do |consultant|
        values = columns.map { |col| consultant.send(col) }
        csv << values
      end
    end
  end

  def primary_phone
    phones.size > 0 ? phones.first.number : ''
  end

  def date_account_created
    created_at
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
end
