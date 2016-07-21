class Company < ActiveRecord::Base

  CREATED_EMAIL_SUBJECT = 'User Requested Company Creation.'
  GLOBAL_CONSULTANT_EXCHANGE = 'Global Consultant Exchange'
  GCES_FEE = 10

  belongs_to :owner, class_name: 'User', inverse_of: :owned_company
  has_many :users
  accepts_nested_attributes_for :owner

  has_many :account_managers, dependent: :destroy

  mount_uploader :contract, ResumeUploader, mount_on: :contract_file_name
  mount_uploader :gsc, ResumeUploader, mount_on: :gsc_file_name

  before_create :store_default_values

  validates :company_name, length: { in: 2..512 }, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
             :uniqueness => { :case_sensitive => false }
  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }

  validates :work_phone,
            presence: true,
            format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
            }

  validates :cell_phone,
            allow_blank: true,
            format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
            }
  validates :contract_start, presence: true, date: { on_or_after: DateTime.now }, on: :create
  validates :contract_end, presence: true, date: { on_or_after: :contract_start }
  validates :contract,
            file_size: { less_than: 10.megabytes },
            file_content_type: { allow: RegexConstants::FileTypes::AS_DOCUMENTS }
  validates :gsc, presence: true, on: :create,
            file_size: { less_than: 10.megabytes },
            file_content_type: { allow: RegexConstants::FileTypes::AS_DOCUMENTS }

  private

  def store_default_values
    self.access_token = SecureRandom.hex(32)
  end
end
