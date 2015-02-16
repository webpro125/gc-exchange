class ContactRequestPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.open?
  end

  alias_method :interested?, :show?
  alias_method :not_interested?, :show?

  def not_pursuing?
    record.can_reply?
  end

  alias_method :hire?, :not_pursuing?
  alias_method :agree_to_terms?, :not_pursuing?
  alias_method :reject_terms?, :not_pursuing?
  alias_method :reply?, :not_pursuing?
end
