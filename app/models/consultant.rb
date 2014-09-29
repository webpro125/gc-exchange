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

  scope :approved, -> { where(approved: true) }

  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }
  after_commit :update_consultant_index, on: [:update]
  after_commit :destroy_consultant_index, on: [:destroy]

  has_attached_file :resume

  has_one :address, dependent: :destroy
  has_one :military, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :project_histories, dependent: :destroy
  has_many :consultant_skills, dependent: :destroy
  has_many :skills, through: :consultant_skills

  validate :phone_length
  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: /\A[A-Za-z\s'-]+\z/,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: /\A[\w\s'-]+\z/,
                      message: 'only allows letters and numbers' }
  validates_attachment :resume,
                       content_type: { content_type: RESUME_MIME_TYPES },
                       size: { less_than: 10.megabytes },
                       file_name: { matches: [/doc\Z/, /docx\Z/, /pdf\Z/] },
                       if: -> { resume.present? }

  def full_name
    "#{first_name} #{last_name}"
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
end
