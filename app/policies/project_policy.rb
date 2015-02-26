class ProjectPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def agree_to_terms?
    user.is_a?(Consultant) && user.projects.include?(record)
  end

  alias_method :not_interested?, :agree_to_terms?
  alias_method :reject_terms?, :agree_to_terms?

  def destroy?
    false
  end

  def new?
    user.is_a?(User) && user.projects.include?(record)
  end

  alias_method :not_pursuing?, :new?
  alias_method :offer?, :new?
  alias_method :create?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :edit?

  def show?
    user.projects.include?(record)
  end
end
