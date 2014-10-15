class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }

  has_many :user_companies, dependent: :destroy
  has_many :companies, through: :user_companies

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_DASHES,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: 'only allows letters and numbers' }
  validates :email, presence: true

  private

  def skip_confirmation_in_staging
    skip_confirmation!
  end
end
