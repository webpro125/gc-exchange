class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:register_account_manager, :put_account_manager]
  before_action :load_am_by_token, only: [:register_account_manager, :put_account_manager]

  def index
    render layout: 'mapbox'
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
    email_content = AccountManager::BUR_CREATED_EMAIL_CONTENT1
    email_content_for_admin = AccountManager::BUR_CREATED_EMAIL_CONTENT2
    if @form.validate(register_am_params) && @form.save
      AccountManagerMailer.created_business_role_name(@account_manager, current_user).deliver
      email_content.gsub!("{user_name}", current_user.full_name)
      email_content.gsub!("{business_unit_name}", @account_manager.business_unit_name)
      email_content_for_admin.gsub!("{company_name}", @owned_company.company_name)
      email_content_for_admin.gsub!("{business_unit_name}", @account_manager.business_unit_name)
      email_content_for_admin.gsub!("{account_manager_name}", @account_manager.company.owner.full_name)

      Admin.all.each {|admin|
        Mailboxer.uses_emails = false
        conversation = current_user.send_message(admin,
                                                 email_content_for_admin,
                                                 'One user registered Account Manager').conversation
        send_sms(admin.phone, email_content_for_admin) unless admin.phone.blank?
      }
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
