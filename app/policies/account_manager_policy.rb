class AccountManagerPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

end
