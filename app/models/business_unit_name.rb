class BusinessUnitName < ActiveRecord::Base
  has_many :business_unit_roles, dependent: :destroy
  belongs_to :account_manager
  attr_accessor :cell_area_code, :cell_prefix, :cell_line
  before_save :store_phone

  def created_email user
    email_text = 'Hello {user_name},
    Thank you for registering your Business Unit {business_unit_name} on GCES.
    To complete the set up process, please assign users to one or more of the 3 Business Unit roles on the system:
    Selection Authority, Requisition Authority, and Approval Authority.
    This will allow you to hire consultant in the GCES network.'
    email_text.gsub!("{user_name}", user.full_name)
    email_text.gsub!("{business_unit_name}", self.name)
    email_text
  end

  def created_email_for_admin user
    email_text = 'The Client Company {company_name} has registered a new Business Unit called
      {business_unit_name}. The Account Manager for this Business Unit is {account_manager_name}'
    email_text.gsub!("{company_name}", self.account_manager.company.company_name)
    email_text.gsub!("{business_unit_name}", self.name)
    email_text.gsub!("{account_manager_name}", self.account_manager.company.owner.full_name)
    email_text
  end

  private

  def store_phone
    unless self.cell_area_code.blank? && self.cell_prefix.blank? && self.cell_line.blank?
      self.account_manager.phone = "#{self.cell_area_code}-#{self.cell_prefix}-#{self.cell_line}"
      self.account_manager.save
    end
    self.access_token = SecureRandom.hex(32)
  end
end
