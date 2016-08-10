class Message
  extend ActiveModel::Naming

  attr_accessor :user_id, :subject, :message, :attachment

  def persisted?
    false
  end

  def to_key
    [1]
  end
end
