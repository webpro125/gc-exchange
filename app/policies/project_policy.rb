class ProjectPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def destroy?
    false
  end

  def new?
    user.is_a?(User) && user.projects.include?(record)
  end

  alias_method :create?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :edit?

  def show?
    user.projects.include?(record)
  end

  alias_method :interested?, :show?
  alias_method :not_interested?, :show?
  alias_method :agree_to_terms?, :show?
  alias_method :reject_terms?, :show?
  alias_method :not_pursuing?, :show?
  alias_method :hire?, :show?
  alias_method :reply?, :show?
end
