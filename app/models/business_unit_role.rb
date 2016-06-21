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
            :uniqueness => { :case_sensitive => false, :scope => :account_manager_id },
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }

  validates :requisition_authority,
            :uniqueness => { :scope => :account_manager_id}, if: :requisition_authority
  validates :approval_authority,
            :uniqueness => { :scope => :account_manager_id}, if: :approval_authority
  validate :authority_required

  def business_unit_name
    account_manager.business_unit_name
  end

  private

  def authority_required
    if !requisition_authority && !approval_authority && !selection_authority
      errors.add(:authority_required, "You need to assign at least one authority!")
    end
  end
end
