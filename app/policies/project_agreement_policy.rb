class ProjectAgreementPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope.joins(project: :business_unit_role)
          .where(business_unit_roles:
             { account_manager_id: BusinessUnitRole.own_requisition_authorities(user).collect(&:account_manager_id)}
          )
    end

  end


  def new?
    # user.is_a?(User) && user.projects.include?(record)
    record.project.consultant == user.consultant
  end

  alias_method :create?, :new?
end
