require 'reform/form/coercion'

class InviteAccountManagerForm < Reform::Form

  model :account_manager

  property :first_name
  property :last_name
  property :email
  property :user_id
  property :access_token

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
end
