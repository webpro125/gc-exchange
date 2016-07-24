class AccountManagersController < ApplicationController
  before_action :authenticate_user!, except: [:autocomplete_user_email, :accept]
  before_action :load_am, except: [:new, :create, :autocomplete_user_email, :accept]
  before_action :load_owned_company, only: [:new, :create]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]

  def new
    @new_design = true
    account_manager = @owned_company.account_managers.build
    # email_content = AccountManager::DEFAULT_EMAIL_CONTENT
    account_manager.email_content = account_manager.invite_am_email(current_user, @owned_company)

    @form = InviteAccountManagerForm.new(account_manager)
  end

  def create
    @new_design = true
    account_manager = @owned_company.account_managers.build
    @form = InviteAccountManagerForm.new(account_manager)
    random_token = SecureRandom.hex(32)

    if @form.validate(send_invite_params)
      user =  User.find_by_email(@form.email)

      if user.blank?
        user = User.create_user(@form)
      end

      @form.user_id = user.id
      @form.access_token = random_token
      @form.email_content.gsub!("<invited_user_name>", user.full_name)
    end

    if @form.validate(send_invite_params) && @form.save

      CompanyMailer.delay.invite_account_manager(@form.model)

      redirect_to root_path, notice: I18n.t('controllers.sales_lead.create.success')
    else
      render :new, notice: @form.errors
    end
  end

  def update_assign_business_role
    @new_design = true
    unit_role = BusinessUnitRole.find(params[:account_manager_id])
    if unit_role.update(business_role_params)
      redirect_to root_path, notice: t('controllers.account_manager.assign_role.success')
    else render :assign_business_role
    end
  end

  def accept
    @account_manager = AccountManager.find_by_access_token(params[:access_token])

    raise Pundit::NotAuthorizedError if @account_manager.blank?

    user = @account_manager.user

    sign_in(user)

    if user.system_created
      redirect_to new_change_password_path(referrer: 'account_manager', token: params[:access_token])
    else
      @account_manager.update_attributes(access_token: '')
      redirect_to new_business_unit_name_path, notice: 'Please Create Your Business Unit Name'
    end

  end

  private

  def load_am
    authorize :user, :load_am?
    @account_manager = current_user.account_manager
    @unit_roles = @account_manager.business_unit_roles
    @owned_company = @account_manager.company
  end

  def load_owned_company
    raise Pundit::NotAuthorizedError unless current_user.owned_company.present?
    @owned_company = current_user.owned_company
  end

  def send_invite_params
    params.require(:account_manager).permit(:first_name, :last_name, :email, :email_content)
  end
end
