class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize_article, only: [:edit, :update]
  def index
    @articles = Article.order(created_at: :desc).page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_comments_path(@article), notice: t('controllers.article.update.success')
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def load_and_authorize_article
    @article = Article.find(params[:id])
    authorize @article
  end
end
