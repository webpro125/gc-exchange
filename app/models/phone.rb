class Phone < ActiveRecord::Base

  belongs_to :phone_type
  belongs_to :phoneable, polymorphic: true

  before_validation :set_phone

  validates :phone_type_id, presence: true
  validates :number, presence: true

  protected
    def set_phone
      self.number = ApplicationController.helpers.number_to_phone(self.number)
    end
end
