class Phone < ActiveRecord::Base
  belongs_to :phone_type
  belongs_to :phoneable, polymorphic: true

  before_validation :set_phone

  validates :phoneable_id, presence: true
  validates :phoneable_type, presence: true
  validates :phone_type, presence: true
  validates :number, presence: true

  protected

  def set_phone
    self.number = ApplicationController.helpers.number_to_phone(number)
  end
end
