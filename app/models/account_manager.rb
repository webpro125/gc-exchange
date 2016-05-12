class AccountManager < ActiveRecord::Base
  include Nameable
  before_save :store_phone

  DEFAULT_EMAIL_CONTENT = 'You were referred to Global Consultand Exchange Services (GCES) to act
    in the role of Account Manager for your company {company_name}.


    Please click the button below to learn more and to start the registration process.{link}'

  belongs_to :user
  belongs_to :company
  has_many :business_unit_roles, dependent: :destroy

  attr_accessor :cell_area_code, :cell_prefix, :cell_line

  private

  def store_phone
    unless @cell_area_code.blank? && @cell_prefix.blank? && @cell_line.blank?
      self.phone = "#{@cell_area_code}-#{@cell_prefix}-#{@cell_line}"
    end
  end

  def is_account_manager?
    business_unit_name.exists?
  end
end
