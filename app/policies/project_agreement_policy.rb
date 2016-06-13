class ProjectAgreementPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end


  def new?
    # user.is_a?(User) && user.projects.include?(record)
    record.project.consultant == user.consultant
  end
  alias_method :create?, :new?
end
