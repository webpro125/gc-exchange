class CompanyRegistrationRequest
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :first_name, :last_name, :company_name, :email, :message

  validates :first_name, :last_name, format: { with: /\A[a-zA-Z\s]+\z/,
                                               message: 'only allows letters' }
  validates :company_name, :message, presence: true
  validates :email, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
