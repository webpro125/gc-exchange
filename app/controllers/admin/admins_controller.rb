class Admin::AdminsController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!
  before_action :load_admin, only: [:edit, :update, :destroy]
  def index
    @admins = Admin.order(created_at: :desc)
  end
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_admins_path, notice: t('controllers.admin.create.success') }
        format.json { render json: admin_companies_path, status: :created, location: @admin }
      else
        format.html { render action: "new", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_admins_path, notice: t('controllers.admin.update.success') }
        format.json { render json: admin_admins_path, status: :created, location: @admin }
      else
        format.html { render action: "edit", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @admin.destroy
        format.html { redirect_to admin_admins_path, notice: t('controllers.admin.destroy.success') }
        format.json { render json: admin_admins_path, status: :created, location: @admin }
      else
        @admins = Admin.order(created_at: :desc)
        format.html { render action: "index", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def load_admin
    @admin = Admin.find(params[:id])
  end
end
