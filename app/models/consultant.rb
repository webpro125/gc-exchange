class Consultant < ActiveRecord::Base
  RESUME_MIME_TYPES = ['application/msword',
                       'application/vnd.ms-word',
                       'applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document',
                       'application/pdf']
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :resume

  has_one :address, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :project_histories, dependent: :destroy
  has_many :consultant_skills, dependent: :destroy
  has_many :skills, through: :consultant_skills

  validate :phone_length
  validates :first_name, length: { in: 3..24 }, presence: true,
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

  private

  def phone_length
    errors.add(:phones, :too_long, count: 3) if phones.size > 3
  end
end
