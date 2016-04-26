class CommentPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.article.status == 'open'
  end

  def show?
    false
  end

  def update?
    record.commenter == user || record.admin_commenter == user
  end

  alias_method :edit?, :update?
  alias_method :load_comment?, :update?

end