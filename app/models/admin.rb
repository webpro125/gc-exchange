class Admin < ActiveRecord::Base
  include Nameable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
end
