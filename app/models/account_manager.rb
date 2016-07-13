class AccountManager < ActiveRecord::Base
  include Nameable
  before_save :store_phone

  DEFAULT_EMAIL_CONTENT = '
    You have been referred to Global Consultant Exchange Services (GCES) by {user_name} who is your Company Contract POC.
    You have been selected to perform the role of Business Unit Account Manager for your company {company_name}.
    Please log into to site and accept your role as Account Manager.'
  BUR_CREATED_EMAIL_CONTENT1 = 'Hello {user_name},
    Thank you for registering your Business Unit {business_unit_name} on GCES.
    To complete the set up process, please assign users to one or more of the 3 Business Unit roles on the system:
    Selection Authority, Requisition Authority, and Approval Authority.
    This will allow you to hire consultant in the GCES network.'
  BUR_CREATED_EMAIL_CONTENT2 = 'The Client Company {company_name} has registered a new Business Unit called
  {business_unit_name}. The Account Manager for this Business Unit is {account_manager_name}'
  belongs_to :user, autosave: true
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
