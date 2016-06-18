class BusinessUnitRole < ActiveRecord::Base

  belongs_to :user, inverse_of: :business_unit_roles
  belongs_to :account_manager

  scope :own_selection_authorities, -> (user_id) { where(selection_authority: true, user_id: user_id) }
  scope :own_requisition_authorities, -> (user) { where(requisition_authority: true, user_id: user.id) }
  has_many :projects

  validates :first_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }

  validates :email, length: { in: 3..128 }, presence: true,
            :uniqueness => { :case_sensitive => false,:scope => :account_manager_id },
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }


  def business_unit_name
    account_manager.business_unit_name
  end
end
