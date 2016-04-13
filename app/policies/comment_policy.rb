class CommentPolicy < LoggedInPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.article.status == 'open'
  end
  # def edit?
  #   user == record.user
  # end
  #
  # alias_method :update?, :edit?
  def show?
    false
  end

  def update?
    record.commenter == user || record.admin_commenter == user
  end
end