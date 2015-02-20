class Message
  # include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :subject, :message

  # validates :subject, presence: true, length: { in: 2..128 }
  # validates :message, presence: true, length: { in: 2..5000 }

  private

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    return false
  end
end
