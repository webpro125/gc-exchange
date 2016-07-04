class Admin < ActiveRecord::Base
  include Nameable

  acts_as_messageable

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
  validates :phone,
            presence: true,
            format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
            }

  has_many :admin_owned_comments, class_name: 'Comment',
           foreign_key: :admin_commenter_id, inverse_of: :commenter,
           dependent: :restrict_with_error
  has_many :articles, dependent: :restrict_with_error

  def mailboxer_email(_object)
    email
  end

end
