class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:register_account_manager, :put_account_manager]
  before_action :load_am_by_token, only: [:register_account_manager, :put_account_manager]

  def index

  end

  def create_consultant
    redirect_to consultant_root_path
  end

  def registration_process
    @new_design = true
  end

  def register_account_manager
    @new_design = true
  end

  def put_account_manager
    @new_design = true
    email_content = AccountManager::BUSINESS_CREATED_EMAIL_CONTENT
    if @form.validate(register_am_params) && @form.save
      AccountManagerMailer.created_business_role_name(@account_manager, current_user).deliver
      @account_manager.email_content.gsub!("{user_name}", current_user.full_name)
      @account_manager.email_content.gsub!("{busienss_name}", @account_manager.business_unit_name)
      # conversation = current_user.send_message(admin,
      #                                          email_content,
      #                                          Company::CREATED_EMAIL_SUBJECT).conversation
      send_sms(@form.phone, email_content) unless @form.phone.blank?

      redirect_to new_business_unit_role_path, notice: t('controllers.account_manager.business_unit.create.success')
    else
      render :register_account_manager
    end
  end

  def workflow
    @new_design = true
  end

  private

  def load_am_by_token
    access_token = params[:access_token]
    @account_manager = AccountManager.find_by_access_token(access_token)
    @owned_company = @account_manager.company
    if @account_manager.blank?
      @error_message = 'Invalid Token'
    elsif @account_manager.business_unit_name.blank?
      sign_in(@account_manager.user)

      @form = RegisterAccountManagerForm.new(@account_manager)
    else
      @error_message = 'You already registered'
    end
  end

  def register_am_params
    params.require(:account_manager).permit(:business_unit_name, :phone, :cell_area_code,
                                            :cell_prefix, :cell_line)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end