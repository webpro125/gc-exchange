class ProjectHistoryPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def edit?
    user.project_histories.include?(record)
  end

  def show?
    false
  end

  alias_method :create?, :edit?
  alias_method :update?, :edit?
  alias_method :destroy?, :edit?
end
