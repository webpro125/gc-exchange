class AddressPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def create?
    record.present? && user.address == record
  end

  alias_method :edit?, :create?
  alias_method :update?, :create?

  def destroy?
    false
  end
end
