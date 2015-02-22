class ChangePasswordsController < ApplicationController
  before_action :load_and_authorize_user

  def edit
  end

  def update
    if is_current_password?(params[:user][:current_password]) && @user.update(password_params)

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

  def is_current_password?(current_password)
    current_user.valid_password?(current_password)
  end

  def load_and_authorize_user
    @user = current_user
    authorize @user, :edit?
  end
end
