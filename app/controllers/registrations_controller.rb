class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: :create
  before_filter :configure_permitted_change_password, only: :update

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :first_name, :last_name)
    end
  end

  def configure_permitted_change_password
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:password, :password_confirmation, :current_password)
    end
  end
end
