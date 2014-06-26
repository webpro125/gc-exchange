module ApplicationHelper
  def development?
    Rails.env.development?
  end
end
