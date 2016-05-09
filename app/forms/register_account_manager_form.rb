require 'reform/form/coercion'

class RegisterAccountManagerForm < Reform::Form

  model :account_manager

  property :business_unit_name
  property :cell_area_code
  property :cell_prefix
  property :cell_line
  property :phone
  validates :business_unit_name, length: { in: 2..64 }, presence: true,
            :uniqueness => { :case_sensitive => false },
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :cell_area_code, :cell_prefix, length: { is: 3 }, presence: true,  :numericality => true
  validates :cell_line, length: { is: 4 }, presence: true,  :numericality => true
end
