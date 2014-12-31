class UserPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.gces? || user.owned_company == record.company
  end

  alias_method :create?, :new?
  alias_method :show?, :new?

  def edit?
    new? || record == user
  end

  alias_method :update?, :edit?

  def destroy?
    new? && user != record
  end

  def upload_resume?
    user == record || user.gces?
  end

  alias_method :upload_image?, :upload_resume?
end
