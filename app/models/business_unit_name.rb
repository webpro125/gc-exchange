class BusinessUnitName < ActiveRecord::Base
  has_many :business_unit_roles, dependent: :destroy
  belongs_to :account_manager
  attr_accessor :cell_area_code, :cell_prefix, :cell_line
  before_save :store_phone

  private

  def store_phone
    unless self.cell_area_code.blank? && self.cell_prefix.blank? && self.cell_line.blank?
      self.account_manager.phone = "#{self.cell_area_code}-#{self.cell_prefix}-#{self.cell_line}"
      self.account_manager.save
    end
  end
end
