class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :company
  has_one :owned_company, class_name: 'Company', foreign_key: :owner_id, inverse_of: :owner

  before_validation :company_present
  before_validation :set_password, on: :create
  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }
  before_destroy :validate_company_owner

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_DASHES,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :email, presence: true
  validates :company, presence: true

  def company_present
    self.company = owned_company if owned_company.present?
  end

  def gces?
    c = owned_company || company
    c.company_name == Company::GLOBAL_CONSULTANT_EXCHANGE
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def validate_company_owner
    return unless owned_company.present?

    errors[:base] = I18n.t('activerecord.errors.models.user.attempt_owner_delete')
    false
  end

  def skip_confirmation_in_staging
    skip_confirmation!
  end

  def set_password
    self.password = self.password_confirmation = Devise.friendly_token.first(8)
  end
end