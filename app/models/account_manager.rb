class AccountManager < ActiveRecord::Base
  include Nameable
  before_save :store_phone

  belongs_to :user
  belongs_to :company
  has_many :business_unit_roles, dependent: :destroy

  attr_accessor :area_code, :prefix, :line

  mount_uploader :avatar, ProfileImageUploader, mount_on: :avatar_file_name

  private

  def store_phone
    unless @area_code.blank? && @prefix.blank? && @line.blank?
      self.phone = "#{@area_code}-#{@prefix}-#{@line}"
    end
  end

end
