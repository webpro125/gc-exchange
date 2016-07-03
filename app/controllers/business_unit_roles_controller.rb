class BusinessUnitRolesController < ApplicationController
  before_action :authenticate_user!, except: [:autocomplete_user_email, :accept_role, :put_accept_role]
  before_action :load_current_am, except: [:autocomplete_user_email]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]
  before_action :load_bur_by_token, only: [:accept_role, :put_accept_role]

  def new
    @new_design = true
    @unit_role = @account_manager.business_unit_roles.build
  end

  def create
    @new_design = true

    @unit_role = BusinessUnitRole.where(email: params[:business_unit_role][:email], account_manager_id: @account_manager.id).first
    generated_password = Devise.friendly_token.first(8)
    accept_token = SecureRandom.hex(32)

    @unit_role.accept_token = accept_token
    @unit_role.sa_accept = false
    @unit_role.ra_accept = false
    @unit_role.aa_accept = false

    if @unit_role.blank?
      @unit_role = @account_manager.business_unit_roles.build(business_role_params)
      user = User.where(email:@unit_role.email).first

      if @unit_role.valid?
        if user.blank?
          user = User.create! do |u|
            u.password = generated_password
            u.first_name = @unit_role.first_name
            u.last_name = @unit_role.last_name
            u.skip_confirmation!
          end
        else
          generated_password = ''
        end
        @unit_role.user_id = user.id
      end

      save_result = @unit_role.save
    else
      save_result = @unit_role.update_attributes(business_role_params)
      user = @unit_role.user
      generated_password = ''
    end

    if save_result
      AccountManagerMailer.delay.assigned_role(user, generated_password, accept_token)
      assigned_role_text = ''
      if @unit_role.selection_authority
        assigned_role_text += 'Selection Authority  '
      elsif @unit_role.approval_authority
        assigned_role_text += 'Approval Authority  '
      elsif @unit_role.requisition_authority
        assigned_role_text += 'Requisition Authority  '
      end
      email_content =
          "One User assigned to business unit role \n
          User Name: #{user.full_name}
          User Email: #{user.email}\n
          Assigned Role: #{assigned_role_text}
          "
      Admin.all.each {|admin|
        conversation = current_user.send_message(admin,
                                                 email_content,
                                                 BusinessUnitRole::ASSIGNED_EMAIL_SUBJECT).conversation
      }

      flash[:notice] = t('controllers.account_manager.assign_role.success')
      render json: @unit_role, status: :ok, notice: t('controllers.account_manager.assign_role.success')
    else
      # format.html { render :assign_business_role }
      render json: @unit_role.errors, status: :unprocessable_entity
    end
  end

  def accept_role
  end

  def put_accept_role
    if @unit_role.selection_authority
      @form.sa_accept = true
    elsif @unit_role.approval_authority
      @form.aa_accept = true
    elsif @unit_role.requisition_authority
      @form.ra_accept = true
    end

    if @form.validate(accept_role_params) && @form.save
      redirect_to root_path, notice: 'You accepted your business unit role'
    else
      render :accept_role
    end
  end

  private

  def load_current_am
    @account_manager = current_user.account_manager
    unless @account_manager.present?
      redirect_to registration_process_users_path, flash: {alert: 'You have no permission to access that page'}
    end
    @unit_roles = @account_manager.business_unit_roles
    @owned_company = @account_manager.company
  end

  def business_role_params
    params.require(:business_unit_role).permit(:first_name, :last_name, :email,
                                               :selection_authority, :requisition_authority, :approval_authority)
  end

  def load_bur_by_token
    @new_design = true
    @unit_role = BusinessUnitRole.find_by_accept_token(params[:accept_token])
    if @unit_role.blank?
      redirect_to root_path, flash: {alert: 'You are not authorized to access this page'}
    else
      sign_in(@unit_role.user)
      @form = BurAcceptForm.new(@unit_role)
    end
  end

  def accept_role_params
    params.require(:business_unit_role).permit(:cell_area_code, :cell_prefix, :cell_line)
  end
end
