class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_article
  before_action :load_comments, only: [:index, :create]
  def index
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.commenter_id = current_user.id
    @comment.article_id = @article.id

    if @comment.save
      redirect_to article_comments_path(@article), notice: t('controllers.comment.create.success')
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
