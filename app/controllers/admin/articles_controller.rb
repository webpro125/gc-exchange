class Admin::ArticlesController < ArticlesController
  layout 'application_admin'
  before_action :load_article, only:[:close_article, :open_article, :destroy]
  before_action :authenticate_admin!

  def index
    super
  end

  def new
    super
  end

  def edit
    authorize_article
    super
  end

  def update
    super
  end

  def create
    super
  end

  def close_article
    @article.status = 1
    if @article.save
      redirect_to admin_article_comments_path(@article), notice: t('controllers.article.close.success')
    else
      redirect_to admin_article_comments_path(@article), notice: t('controllers.article.close.fail')
    end
  end

  def open_article
    @article.status = 0
    if @article.save
      redirect_to admin_article_comments_path(@article), notice: t('controllers.article.open.success')
    else
      redirect_to admin_article_comments_path(@article), notice: t('controllers.article.open.fail')
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path, notice: t('controllers.article.destroy.success')
  end

  private

  def authorize_article
    if user_signed_in? && admin_signed_in?
      redirect_to admin_articles_path, notice: t('controllers.article.update.no_permission') if current_admin != @article.admin
    end
  end

  def load_article
    @article = Article.find(params[:id])
    authorize @article unless user_signed_in? && admin_signed_in?
  end
end