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
    new? || record.owner_id == user.id
  end

  def show?
    new? || record.users.include?(user)
  end

  alias_method :create?, :new?
  alias_method :destroy?, :new?
  alias_method :update?, :edit?
end
