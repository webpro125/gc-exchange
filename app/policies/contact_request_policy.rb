class ContactRequestPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.contact_requests.include?(record)
  end

  alias_method :interested?, :show?
  alias_method :not_interested?, :show?
  alias_method :agree_to_terms?, :show?
  alias_method :reject_terms?, :show?
  alias_method :not_pursuing?, :show?
  alias_method :hire?, :show?
  alias_method :reply?, :show?
end
