class Admin::UsersController < Admin::CompanyController
  before_action :load_company

  def new
    @user = @company.users.build
  end

  def create
    @user = @company.users.build(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_admin_company_path(@company), notice: t('controllers.user.create.success') }
        format.json { render json: edit_admin_company_path(@company), status: :created, location: @user }
      else
        format.html { render action: "new", notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_admin_company_path(@company), notice: t('controllers.user.update.success') }
        format.json { render json: edit_admin_company_path(@company), status: :created, location: @user }
      else
        format.html { render action: "edit", notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def load_company
    @company = Company.find(params[:company_id])
  end
end
