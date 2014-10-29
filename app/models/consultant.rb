class Consultant < ActiveRecord::Base
  include Searchable

  RESUME_MIME_TYPES = ['application/msword',
                       'application/vnd.ms-word',
                       'applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document',
                       'application/pdf']
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :approved, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::APPROVED))
  end)
  scope :pending_approval, (lambda do
    where(approved_status: ApprovedStatus.find_by_code(ApprovedStatus::PENDING_APPROVAL))
  end)

  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }
  before_create :set_approved_status
  after_commit :update_consultant_index, on: [:update]
  after_commit :destroy_consultant_index, on: [:destroy]

  has_attached_file :resume

  has_one :address, dependent: :destroy
  has_one :military, dependent: :destroy
  belongs_to :approved_status
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :project_histories, dependent: :destroy
  has_many :consultant_skills, dependent: :destroy
  has_many :skills, through: :consultant_skills
  has_many :consultant_certifications, dependent: :destroy
  has_many :certifications, through: :consultant_certifications

  validate :phone_length
  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_DASHES,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: 'only allows letters and numbers' }
  validates :consultant_certifications, length: { maximum: 10 }
  validates :consultant_skills, length: { maximum: 20 }
  validates :rate, numericality: { greater_than: 0 }, allow_blank: true
  validates_attachment :resume,
                       content_type: { content_type: RESUME_MIME_TYPES },
                       size: { less_than: 10.megabytes },
                       file_name: { matches: RegexConstants::FileTypes::AS_DOCUMENTS },
                       if: -> { resume.present? }

  def full_name
    "#{first_name} #{last_name}"
  end

  def approved?
    approved_status.code == ApprovedStatus::APPROVED
  end

  def rejected?
    approved_status.code == ApprovedStatus::REJECTED
  end

  def pending_approval?
    approved_status.code == ApprovedStatus::PENDING_APPROVAL
  end

  def in_progress?
    approved_status.code == ApprovedStatus::IN_PROGRESS
  end

  def skills_list
    skills.pluck(:code)
  end

  private

  def phone_length
    errors.add(:phones, :too_long, count: 3) if phones.size > 3
  end

  def skip_confirmation_in_staging
    skip_confirmation!
  end

  def destroy_consultant_index
    delete_document
  end

  def update_consultant_index
    ConsultantIndexer.perform_async(:update, id) if approved?
  end

  def set_approved_status
    self.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::IN_PROGRESS)
  end
end
