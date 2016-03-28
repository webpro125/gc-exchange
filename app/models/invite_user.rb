class InviteUser < ActiveRecord::Base
  include Nameable

  belongs_to :company

  validates :company, presence: true
  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

end
