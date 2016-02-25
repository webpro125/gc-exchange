class AdminPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    # admin.gces? || admin.owned_company == record.company
  end

  alias_method :create?, :new?
  alias_method :show?, :new?

  def edit?
    new? || record == admin
  end

  alias_method :update?, :edit?

  def destroy?
    new? && admin != record
  end

  def upload_resume?
    admin == record || admin.gces?
  end

  alias_method :upload_image?, :upload_resume?

  def update_password?
    admin == record
  end
end
