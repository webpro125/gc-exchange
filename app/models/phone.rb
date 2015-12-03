class Phone < ActiveRecord::Base
  belongs_to :phone_type
  belongs_to :phoneable, polymorphic: true

  before_validation :set_phone

  validates :phoneable, associated: true

  attr_accessor :_destroy # TODO: Remove when Reform releases _destroy

  def number_with_ext
    if ext.present?
      "#{number} Ext: #{ext}"
    else
      number
    end
  end

  protected

  def set_phone
    self.number = ApplicationController.helpers.number_to_phone(number)
  end
end
