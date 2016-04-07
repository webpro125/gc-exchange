class ArticlesController < ApplicationController
  before_action :auth_a_user!
  before_action :load_and_authorize_article, only: [:edit, :update]
  def index
    @articles = Article.order(created_at: :desc).page(params[:page])
  end

  def new
    @article = Article.new
    @article_attachment = @article.article_attachments.build
  end

  def create
    @article = Article.new(article_params)

    if user_signed_in?
      @article.user_id = pundit_user.id
    else
      @article.admin_id = pundit_user.id
    end

    if @article.save

      upload_attachment

      redirect_to (user_signed_in? ? articles_path : admin_articles_path), notice: t('controllers.article.create.success')
    else
      render :new
    end
  end

  def edit
    @article_attachment = @article.article_attachments.build
    authorize_article
  end

  def update
    if @article.update(article_params)

      upload_attachment

      redirect_to (user_signed_in? ? article_comments_path(@article) : admin_article_comments_path(@article)),
                  notice: t('controllers.article.update.success')
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, article_attachments_attributes: [:id, :article_id, :attach, :_destroy])
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

  def upload_attachment
    unless params[:article_attachments].blank?
      params[:article_attachments]['attach'].each do |a|
        @post_attachment = @article.article_attachments.create!(:attach => a)
      end
    end
  end
end
