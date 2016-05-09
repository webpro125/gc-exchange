class AccountManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_current_am, except: [:new, :create]
  before_action :load_owned_company, only: [:new, :create]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]

  def new
    @new_design = true
    account_manager = @owned_company.account_managers.build

    @form = InviteAccountManagerForm.new(account_manager)
  end

  def create
    @new_design = true
    account_manager = @owned_company.account_managers.build
    @form = InviteAccountManagerForm.new(account_manager)
    random_token = SecureRandom.hex(32)

    generated_password = ''

    if @form.validate(send_invite_params)

      generated_password = Devise.friendly_token.first(8) if User.where(email:@form.email).first.blank?

      user = User.where(email:@form.email).first_or_create! do |user|
        user.password = generated_password
        user.first_name = @form.first_name
        user.last_name = @form.last_name
        user.skip_confirmation!
      end
      @form.user_id = user.id
      @form.access_token = random_token
    end

    if @form.validate(send_invite_params) && @form.save

      # 'Message was successfully sent'
      CompanyMailer.invite_account_manager(AccountManager.find(@form.id), generated_password).deliver

      redirect_to root_path, notice: I18n.t('controllers.sales_lead.create.success')
    else
      render :new, notice: @form.errors
    end
  end

  def assign_business_role
    @new_design = true
    @unit_role = @account_manager.business_unit_roles.build
  end

  def do_assign_business_role

    @new_design = true
    @unit_role = @account_manager.business_unit_roles.build(business_role_params)

    if @unit_role.valid?
      if User.where(email:@unit_role.email).first.blank?
        generated_password = Devise.friendly_token.first(8)
      else
        generated_password = ''
      end
      user = User.where(email:@unit_role.email).first_or_create! do |user|
        user.password = generated_password
        user.first_name = @unit_role.first_name
        user.last_name = @unit_role.last_name
        user.skip_confirmation!
      end
      @unit_role.user_id = user.id
    end

    if @unit_role.save
      redirect_to assign_business_role_account_managers_path, notice: t('controllers.account_manager.assign_role.success')
    else render :assign_business_role
    end
  end

  def update_assign_business_role
    @new_design = true
    unit_role = BusinessUnitRole.find(params[:account_manager_id])
    if unit_role.update(business_role_params)
      redirect_to assign_business_role_account_managers_path, notice: t('controllers.account_manager.assign_role.success')
    else render :assign_business_role
    end
  end

  private

  def load_current_am
    @account_manager = current_user.account_manager
    if @account_manager.blank?
      redirect_to root_path, flash: {alert: 'You have no permission to access that page'}
    end
    @unit_roles = @account_manager.business_unit_roles
  end

  def load_owned_company
    unless current_user.owned_company.present?
      redirect_to root_path, flash: {alert: 'You have no permission to access that page'}
    end
    @owned_company = current_user.owned_company
  end

  def business_role_params
    params.require(:business_unit_role).permit(:first_name, :last_name, :email,
                   :selection_authority, :requisition_authority, :approval_authority)
  end

  def send_invite_params
    params.require(:account_manager).permit(:first_name, :last_name, :email, :email_content)
  end
end
