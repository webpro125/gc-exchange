class BusinessUnitRole < ActiveRecord::Base

  ASSIGNED_EMAIL_SUBJECT = 'Assigned Business Unit Role'
  belongs_to :user, inverse_of: :business_unit_roles
  belongs_to :business_unit_name

  scope :own_selection_authorities, -> (user_id) { where(selection_authority: true, user_id: user_id, sa_accept: true) }
  scope :own_requisition_authorities, -> (user) { where(requisition_authority: true, user_id: user.id, ra_accept: true) }
  has_many :projects, dependent: :destroy
  attr_accessor :cell_area_code, :cell_prefix, :cell_line

  before_save :store_phone

  validates :first_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..64 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }

  validates :email, length: { in: 3..128 }, presence: true,
            # :uniqueness => { :case_sensitive => false, :scope => :business_unit_name_id },
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }

  validates :requisition_authority,
            :uniqueness => { :scope => :business_unit_name_id}, if: :requisition_authority
  validates :approval_authority,
            :uniqueness => { :scope => :business_unit_name_id}, if: :approval_authority
  validate :authority_required

  def account_manager
    business_unit_name.account_manager
  end
  private

  def authority_required
    if !requisition_authority && !approval_authority && !selection_authority
      errors.add(:authority_required, "You need to assign at least one authority!")
    end
  end

  def store_phone
    unless @cell_area_code.blank? && @cell_prefix.blank? && @cell_line.blank?
      self.phone = "#{@cell_area_code}-#{@cell_prefix}-#{@cell_line}"
    end
  end
end
