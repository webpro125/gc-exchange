class ProjectHistoryPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def edit?
    user.project_histories.include?(record)
  end

  alias_method :create?, :edit?
  alias_method :show?, :edit?
  alias_method :update?, :edit?
  alias_method :destroy?, :edit?
end
