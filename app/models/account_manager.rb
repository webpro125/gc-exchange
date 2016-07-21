class AccountManager < ActiveRecord::Base
  include Nameable
  before_save :store_phone

  belongs_to :user, autosave: true
  belongs_to :company
  has_many :business_unit_names, dependent: :destroy
  accepts_nested_attributes_for :business_unit_names
  has_many :business_unit_roles, through: :business_unit_names

  attr_accessor :cell_area_code, :cell_prefix, :cell_line

  def invite_am_email user, company
    email_text = '
      You have been referred to Global Consultant Exchange Services (GCES) by {user_name} who is your Company Contract POC.
      You have been selected to perform the role of Business Unit Account Manager for your company {company_name}.
      Please log into to site and accept your role as Account Manager.'
    email_text.gsub!("{user_name}", user.full_name)
    email_text.gsub!("{company_name}", company.company_name)
    email_text
  end

  private

  def store_phone
    unless @cell_area_code.blank? && @cell_prefix.blank? && @cell_line.blank?
      self.phone = "#{@cell_area_code}-#{@cell_prefix}-#{@cell_line}"
    end

  end

end
