class SalesLead < ActiveRecord::Base
  before_validation :set_phone

  validates :first_name, :last_name, length: { in: 2..24 }, format: { with: /\A[a-zA-Z\s]+\z/,
                                                                      message:
                                                                            'only allows letters' }
  validates :company_name, length: { in: 2..128 }, presence: true
  validates :message, length: { in: 2..10_000 }, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true

  protected

  def set_phone
    self.phone_number = ApplicationController.helpers.number_to_phone(phone_number)
  end
end
