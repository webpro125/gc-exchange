class Project < ActiveRecord::Base
  enum contact_status: [:offered, :rejected, :not_pursuing, :agreed_to_terms, :under_revision]
  enum consultant_location: ['On-Site', :Remote, :Both]

  CREATED_EMAIL_SUBJECT = 'Created Draft'

  scope :open,
        (lambda do
          where(arel_table[:contact_status].eq(Project.contact_statuses[:offered])
                  .or(arel_table[:contact_status].eq(
                        Project.contact_statuses[:under_revision]))
          ).order(:updated_at)
        end)

  mount_uploader :sow, ArticleUploader, mount_on: :sow_file_name

  after_save :save_rate
  before_save :update_sow_attributes
  # belongs_to :travel_authorization
  belongs_to :consultant
  belongs_to :user
  belongs_to :business_unit_role
  has_one :project_agreement, dependent: :destroy
  has_one :work_location_address, dependent: :destroy
  # accepts_nested_attributes_for :work_location_address, allow_destroy: true
  validates :consultant, presence: true
  validates :user, presence: true
  # validates :travel_authorization, presence: true

  def account_manager
    business_unit_role.account_manager
  end

  private

  def save_rate
    self.update_attributes(proposed_rate: consultant.rate) if self.proposed_rate.blank?
  end

  def update_sow_attributes
    if sow.present? && sow_file_name_changed?
      self.sow_content_type = sow.file.content_type
      self.sow_file_size = sow.file.size
    end
  end
end
