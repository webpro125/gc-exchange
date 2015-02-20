class Message
  attr_accessor :subject, :message

  private

  def persisted?
    false
  end

  def to_key
    [1]
  end
end
