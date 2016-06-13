class User < ActiveRecord::Base
  include Nameable, Contactable

  acts_as_messageable

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable

  belongs_to :company
  has_many :projects, ->() { order(updated_at: :desc) }, dependent: :destroy
  has_many :shared_contacts, dependent: :destroy
  has_one :owned_company, class_name: 'Company', foreign_key: :owner_id, inverse_of: :owner
  has_many :owned_comments, class_name: 'Comment', foreign_key: :commenter_id, inverse_of: :commenter
  has_one :consultant, dependent: :destroy

  has_many :phones, through: :consultant, as: :phoneable, dependent: :destroy
  has_many :educations, through: :consultant, dependent: :destroy
  has_one :account_manager
  has_many :requested_company
  has_many :business_unit_roles, inverse_of: :user
  has_many :selection_authorities,  -> () {
    where("selection_authority = ?", true)
  },  class_name: 'BusinessUnitRole', foreign_key: :user_id

  before_validation :company_present
  # before_validation :set_password, on: :create
  before_create :skip_confirmation_in_staging, if: -> { Rails.env.staging? }
  before_create :build_default_consultant

  before_destroy :validate_company_owner

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Words::AND_SPECIAL,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :email, presence: true
  # validates :company, presence: true

  scope :consultants, -> { joins(consultant: :approved_status).merge(ApprovedStatus.where(code: ApprovedStatus::APPROVED[:code])) }
  scope :client_companies, -> { joins(:owned_company) }

  def company_present
    self.company = owned_company if owned_company.present?
  end

  def gces?
    if self.company.present?
      c = owned_company || company
      c.company_name == Company::GLOBAL_CONSULTANT_EXCHANGE
    else false end
  end

  def mailboxer_email(_object)
    email
  end

  def is_consultant?
    consultant.present?
  end
  private

  def validate_company_owner
    return unless owned_company.present?

    errors[:base] = I18n.t('activerecord.errors.models.user.attempt_owner_delete')
    false
  end

  def skip_confirmation_in_staging
    skip_confirmation!
  end

  # def set_password
  #   self.password = self.password_confirmation = Devise.friendly_token.first(8)
  # end

  def send_confirmation_instructions
    # set_password unless password

    super
  end

  def build_default_consultant
    build_consultant
    true # Always return true in callbacks as the normal 'continue' state
  end
end
