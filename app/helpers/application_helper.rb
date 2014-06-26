module ApplicationHelper

  # Determines if we're in a development type environment
  #
  # Returns true for following environments
  # - development
  #
  # Returns false for the following environments
  # - test
  # - production
  def development?
    return Rails.env.development?
  end
end
