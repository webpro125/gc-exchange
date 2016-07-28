require 'reform/form/coercion'

class InviteAccountManagerForm < Reform::Form

  model :account_manager

  property :first_name
  property :last_name
  property :email
  property :user_id
  property :access_token
  property :email_content
  property :company_id

  validates :first_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }

  validates :email, length: { in: 3..128 }, presence: true,
            :uniqueness => { :case_sensitive => false },
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }
  validates :email_content, presence: true
  validate :authorize_company

  private

  def authorize_company
    if BusinessUnitRole.joins(business_unit_name: :account_manager).exists? ["account_managers.company_id != ? AND business_unit_roles.email = ?", company_id.to_i, email]
      errors.add(:email, 'already has been taken')
    end
    if Company.exists? ["email = ? and id != ?", email, company_id.to_i]
      errors.add(:email, 'already has been taken')
    end
  end
end
