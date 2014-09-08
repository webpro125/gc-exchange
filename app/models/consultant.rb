class Consultant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :address, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :project_histories, dependent: :destroy
  has_many :consultant_skills, dependent: :destroy
  has_many :skills, through: :consultant_skills

  validates :first_name, length: { in: 3..24 }, presence: true,
            format: { with: /\A[A-Za-z\s'-]+\z/,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 3..24 }, presence: true,
            format: { with: /\A[\w\s'-]+\z/,
                      message: 'only allows letters and numbers' }

end
