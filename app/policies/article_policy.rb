class ArticlePolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def edit?
    user == record.user || user == record.admin
  end

  def close_article?
    user == record.user || (user.is_a? Admin)
  end

  def destroy?
    user.is_a? Admin
  end

  alias_method :update?, :edit?
  alias_method :open_article?, :close_article?


  def show?
    false
  end


end
