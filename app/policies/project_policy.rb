class ProjectPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def agree_to_terms?
    user.consultant.is_a?(Consultant) && user.consultant.projects.include?(record)
  end

  alias_method :not_interested?, :agree_to_terms?
  alias_method :reject_terms?, :agree_to_terms?

  def destroy?
    false
  end

  def new?
    # user.is_a?(User) && user.projects.include?(record)
    user.selection_authorities.any? && record.consultant.wizard_step == Wicked::FINISH_STEP
  end

  def edit?
    new? && record.rejected?
  end
  alias_method :not_pursuing?, :new?
  alias_method :offer?, :new?
  alias_method :create?, :new?
  alias_method :update?, :edit?

  def show?
    # if namespace is consultant_profile, user = user.consultant
    user.projects.include?(record)
  end
end
