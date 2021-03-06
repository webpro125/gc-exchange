class SalesLead < ActiveRecord::Base
  before_validation :set_phone

  validates :company_name, length: { in: 2..128 }, presence: true
  validates :message, length: { in: 2..5_000 }, presence: true
  validates :email, presence: true, uniqueness: true,
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }
  validates :phone_number, presence: true
  validates :first_name,
            :last_name,
            length: { in: 2..24 },
            presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }

  protected

  def set_phone
    self.phone_number = ApplicationController.helpers.number_to_phone(phone_number)
  end
end
