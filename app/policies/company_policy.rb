class CompanyPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      if user.gces?
        scope
      else
        user.company
      end
    end
  end

  def new?
    user.gces?
  end

  def edit?
    (new? || record.owner_id == user.id) &&
      record.company_name != Company::GLOBAL_CONSULTANT_EXCHANGE
  end

  def show?
    new? || record.users.include?(user)
  end

  def destroy?
    new? && record.company_name != Company::GLOBAL_CONSULTANT_EXCHANGE
  end

  alias_method :create?, :new?
  alias_method :update?, :edit?
end
