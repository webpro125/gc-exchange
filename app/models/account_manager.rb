class AccountManager < ActiveRecord::Base
  include Nameable
  before_save :store_phone

  DEFAULT_EMAIL_CONTENT = '
    You were referred to Global Consultant Exchange Services (GCES) by {user_name} you Company Contract POC.
    You have been selected to perform the role of Business Unit Account Manager for your company {company_name}.
    Please log into to site and accept your role as Account Manager.'

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
