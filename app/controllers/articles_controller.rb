class ArticlesController < ApplicationController
  before_action :auth_a_user!
  before_action :load_and_authorize_article, only: [:edit, :update]
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(7)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if user_signed_in?
      @article.user_id = pundit_user.id
    else
      @article.admin_id = pundit_user.id
    end

    if @article.save
      store_attached
      redirect_to (user_signed_in? ? articles_path : admin_articles_path), notice: t('controllers.article.create.success')
    else
      ArticleAttachment.where(article_id: nil).destroy_all
      render :new
    end
  end

  def edit
    # @article_attachment = @article.article_attachments.build
    authorize_article
  end

  def update
    if @article.update(article_params)
      store_attached
      redirect_to (user_signed_in? ? article_comments_path(@article) : admin_article_comments_path(@article)),
                  notice: t('controllers.article.update.success')
    else
      ArticleAttachment.where(article_id: nil).destroy_all
      render :edit
    end
  end

  def upload_attachment
    if params[:attach_type] == 'article'
      @attachment = ArticleAttachment.new(attach: params[:attachment])
    else
      @attachment = CommentAttachment.new(attach: params[:attachment])
    end

    if @attachment.save
      render json: @attachment, status: :ok
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
  end

  def destroy_attachment
    if params[:attach_type] == 'article'
      @attachment = ArticleAttachment.find(params[:attachment_id])
    else
      @attachment = CommentAttachment.find(params[:attachment_id])
    end
    if @attachment.destroy
      render json: {result: "success"}, status: :ok
    else
      render json: 'error', status: :unprocessable_entity
    end
  end
  private

  def article_params
    params.require(:article).permit(:title, :text, article_attachments_attributes:[:id, :article_id, :attach, :_destroy])
    # params.require(:article).permit(:title, :text)
  end

  def load_and_authorize_article
    @article = Article.find(params[:id])
    authorize @article unless user_signed_in? && admin_signed_in?
  end

  def authorize_article
    if user_signed_in? && admin_signed_in?
      redirect_to articles_path, notice: t('controllers.article.update.no_permission') if current_user != @article.user
    end
  end

  def store_attached
    unless params[:attachment_ids].blank?
      ArticleAttachment.where(:id => params[:attachment_ids].split(",")).update_all(article_id: @article.id)
    end
  end
end
