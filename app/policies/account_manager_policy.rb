class AccountManagerPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def register_account_manager?
    true
  end
end
