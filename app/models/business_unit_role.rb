class BusinessUnitRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :account_manager

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
