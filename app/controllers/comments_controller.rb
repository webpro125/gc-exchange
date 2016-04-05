class CommentsController < ApplicationController
  before_action :auth_a_user!
  before_action :load_article
  before_action :load_comments, only: [:index, :create]

  def index
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if user_signed_in?
      @comment.commenter_id = current_user.id
    else
      @comment.admin_commenter_id = current_admin.id
    end
    @comment.article_id = @article.id
    authorize @comment
    if @comment.save
      redirect_to (user_signed_in? ? article_comments_path(@article) : admin_article_comments_path(@article)),
                  notice: t('controllers.comment.create.success')
    else
      render :index
    end
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_comments
    @comments = @article.comments
  end
end
