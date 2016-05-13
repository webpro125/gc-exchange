class Admin::CommentsController < CommentsController
  layout 'application_admin'
  before_action :authenticate_admin!

  def index
    add_breadcrumb 'Blog', admin_articles_path
    add_breadcrumb @article.title, Proc.new { |c| c.edit_admin_article_path(@article) }
    add_breadcrumb 'Comments', Proc.new { |c| c.admin_article_comments_path(@article) }
    super
  end

  def create
    super
  end

  def update
    super
  end

  def load_comment
    super
  end
end
