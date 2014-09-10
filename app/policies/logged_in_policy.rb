class LoggedInPolicy < ApplicationPolicy
  def initialize(user, record)
    fail Pundit::NotAuthorizedError, 'must be logged in' unless user
    super
  end
end
