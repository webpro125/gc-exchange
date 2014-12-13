class UsersController < CompanyController
  before_action :load_and_authorize_company, except: [:profile]
  before_action :load_and_authorize_user, only: [:show, :edit, :update, :destroy]

  def profile
    @company = current_user.company
    render 'companies/show'
  end

  def index
    @users = policy_scope(@company.users).page(params[:page])
  end

  def new
    @user = @company.users.build
    authorize @user
  end

  def show
  end

  def create
    @user = @company.users.build(user_params)
    authorize @user

    if @user.save
      redirect_to company_user_path(@company, @user), notice: t('controllers.user.create.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to company_user_path(@company, @user), notice: t('controllers.user.update.success')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to company_users_path(@company), notice: t('controllers.user.destroy.success')
  end

  private

  def load_and_authorize_company
    @company = Company.find(params[:company_id])
    authorize @company, :show?
  end

  def load_and_authorize_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
