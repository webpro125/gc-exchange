class CommentsController < ApplicationController
  before_action :auth_a_user!
  before_action :load_article, except: [:load_comment]
  before_action :load_comments, only: [:index, :create]

  def index
    @comment = Comment.new
    @comment.comment_attachments.build
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
      store_attached
      redirect_to (user_signed_in? ? article_comments_path(@article) : admin_article_comments_path(@article)),
                  notice: t('controllers.comment.create.success')
    else
      CommentAttachment.where(comment_id: nil).destroy_all
      render :index
    end
  end

  def update
    @comment = Comment.find(params[:id])

    authorize @comment

    if @comment.update(comment_params)
      store_attached
      render json: @comment, include: :comment_attachments, status: :ok
    else
      CommentAttachment.where(comment_id: nil).destroy_all
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def load_comment
    @comment = Comment.find(params[:comment_id])
    @article = @comment.article
    authorize @comment
    render layout: false
  end
  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body, comment_attachments_attributes: [:id, :comment_id, :attach, :_destroy])
  end

  def load_comments
    @comments = @article.comments
  end

  def store_attached
    unless params[:attachment_ids].blank?
      CommentAttachment.where(:id => params[:attachment_ids].split(",")).update_all(comment_id: @comment.id)
    end
  end
end
