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
  end

  private

  # def load_am_by_token
  #   access_token = params[:access_token]
  #   @account_manager = AccountManager.find_by_access_token(access_token)
  #   @owned_company = @account_manager.company
  #   if @account_manager.blank?
  #     @error_message = 'Invalid Token'
  #   elsif @account_manager.business_unit_name.blank?
  #     sign_in(@account_manager.user)
  #
  #     @form = RegisterAccountManagerForm.new(@account_manager)
  #   else
  #     @error_message = 'You already registered'
  #   end
  # end

  def register_am_params
    params.require(:account_manager).permit(:business_unit_name, :phone, :cell_area_code,
                                            :cell_prefix, :cell_line)
  end

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(request.referrer || root_path)
  # end
end
