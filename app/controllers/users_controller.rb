class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @new_design = true
    @user_count = User.count
    render layout: 'mapbox'
  end

  def create_consultant
    redirect_to consultant_root_path
  end

  def registration_process
    @new_design = true
  end

  def workflow
    @new_design = true
    render layout: false
  end

  def taxonomy
    @new_design = true
    @user = current_user
    authorize @user

    @company = @user.company
  end

  private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer || root_path)
  # end
end
