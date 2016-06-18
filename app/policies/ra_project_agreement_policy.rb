class RaProjectAgreementPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      # scope.joins(project: :business_unit_role)
      #     .where(business_unit_roles:
      #        { account_manager_id: BusinessUnitRole.own_requisition_authorities(user).collect(&:account_manager_id)}
      #     )
    end

  end


  def new?
    # record.project.consultant == user.consultant
    record_am = record.project.account_manager
    AccountManager.where(id: BusinessUnitRole.own_requisition_authorities(user).collect(&:account_manager_id))
              .include?(record_am) && record.project.offered?
  end

  alias_method :create?, :new?
end
