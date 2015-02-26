class Message
  extend ActiveModel::Naming

  attr_accessor :subject, :message

  def persisted?
    false
  end

  def to_key
    [1]
  end
end
