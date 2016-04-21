require 'reform/form/coercion'

class RegisterAccountManagerForm < Reform::Form

  model :account_manager

  property :avatar
  property :business_unit_name
  property :corporate_title
  property :area_code
  property :prefix
  property :line
  property :phone
  validates :business_unit_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :corporate_title, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :corporate_title, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :corporate_title, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :area_code, :prefix, length: { is: 3 }, presence: true,  :numericality => true
  validates :line, length: { is: 4 }, presence: true,  :numericality => true
end
