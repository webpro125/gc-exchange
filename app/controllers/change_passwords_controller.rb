class ChangePasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize_user, only: [:edit, :update]
  before_action :authorize_new_user, only: [:new, :create]

  def new
  end

  def create
    if @user.update(password_params)

      # Sign in the user by passing validation in case their password changed
      sign_in @user, bypass: true

      @user.update_attributes(system_created: false)

      if params[:referrer] == 'company'
        Company.find_by_access_token(params[:token]).update_attributes(access_token: '')
        redirect_to new_account_manager_path, notice: 'Please Invite Account Manager for Your Company'
      elsif params[:referrer] == 'account_manager'
        AccountManager.find_by_access_token(params[:token]).update_attributes(access_token: '')
        redirect_to new_business_unit_name_path
      elsif @referrer == 'business_unit_role'
        redirect_to accept_business_role_path(params[:token]), notice: 'Please Accept Your Business Unit Role'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_password?(params[:user][:current_password]) && @user.update(password_params)

      # Sign in the user by passing validation in case their password changed
      sign_in @user, bypass: true
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def current_password?(current_password)
    @user.valid_password?(current_password)
  end

  def authorize_new_user
    @new_design = true

    @referrer = params[:referrer]
    @token = params[:token]
    @user = current_user

    authorize = false
    if @referrer == 'company'
      company = Company.where(access_token: @token, owner_id: @user.id)
      authorize = true unless company.blank?
    elsif @referrer == 'account_manager'
      account_manager = AccountManager.where(access_token: @token, user_id: @user.id)
      authorize = true unless account_manager.blank?
    elsif @referrer == 'business_unit_role'
      business_unit_role = BusinessUnitRole.where(accept_token: @token, user_id: @user.id)
      authorize = true unless business_unit_role.blank?
    end

    raise Pundit::NotAuthorizedError unless authorize

  end

  def load_and_authorize_user
    @new_design = true
    @user = current_user
    authorize @user, :update_password?
  end
end
