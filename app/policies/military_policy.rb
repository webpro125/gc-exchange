class MilitaryPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.present? && user.military == record
  end

  alias_method :update?, :create?

  def new?
    false
  end

  def show?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end
end
