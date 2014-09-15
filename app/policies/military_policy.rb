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

  def destroy
    false
  end
end
