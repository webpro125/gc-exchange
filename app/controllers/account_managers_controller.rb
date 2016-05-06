class AccountManagersController < ApplicationController
  before_action :load_am_by_token, only: [:register, :do_register]
  before_action :authenticate_user!, except: [:register, :do_register]
  before_action :load_current_am, except: [:register, :do_register, :new, :create]
  before_action :load_owned_company, only: [:new, :create]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]

  def new
    @new_design = true
    account_manager = @owned_company.account_managers.build

    @form = InviteAccountManagerForm.new(account_manager)
  end

  def create
    @new_design = true
  end

  def register
    @new_design = true
  end

  def do_register
    @new_design = true
    if @form.validate(register_params) && @form.save
      sign_in(@account_manager.user)

      redirect_to assign_business_role_account_managers_path
    else
      render :register
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

  def load_am_by_token
    access_token = params[:access_token]
    @account_manager = AccountManager.find_by_access_token(access_token)
    if @account_manager.blank?
        @error_message = 'Invalid Token'
    elsif @account_manager.phone.blank?
      @form = RegisterAccountManagerForm.new(@account_manager)
    else
      @error_message = 'You already registered'
    end
  end

  def register_params
    params.require(:account_manager).permit(:corporate_title, :business_unit_name,
                                            :phone, :area_code, :prefix, :line, :avatar)
  end

  def business_role_params
    params.require(:business_unit_role).permit(:first_name, :last_name, :email,
                   :selection_authority, :requisition_authority, :approval_authority)
  end
end
