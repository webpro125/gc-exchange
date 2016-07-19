class BusinessUnitNamesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_am

  def new
    @business_name = @account_manager.business_unit_names.build
    @form = RegisterAccountManagerForm.new(@business_name)
  end

  def create
    @business_name = @account_manager.business_unit_names.build
    unless @account_manager.phone.blank?
      phone_array = @account_manager.phone.to_s.split('-')
      @business_name.cell_area_code = phone_array[0]
      @business_name.cell_prefix = phone_array[1]
      @business_name.cell_line = phone_array[2]
    end
    @form = RegisterAccountManagerForm.new(@business_name)
    email_content = @form.model.created_email(current_user)
    email_content_for_admin = @form.model.created_email_for_admin(current_user)
    if @form.validate(register_am_params) && @form.save
      AccountManagerMailer.created_business_role_name( @form.model, current_user).deliver

      Admin.all.each {|admin|
        Mailboxer.uses_emails = false
        conversation = current_user.send_message(admin,
                                                 email_content_for_admin,
                                                 'One user registered Account Manager').conversation
        send_sms(admin.phone, email_content_for_admin) unless admin.phone.blank?
      }
      send_sms(@account_manager.phone, email_content) unless @account_manager.phone.blank?

      redirect_to new_business_unit_role_path, notice: t('controllers.account_manager.business_unit.create.success')
    else
      render :new
    end
  end

  private

  def load_am
    authorize :user, :load_am?
    @account_manager = current_user.account_manager
    @owned_company = @account_manager.company
    @new_design = true
  end

  def register_am_params
    params.require(:business_unit_name).permit(:name, :cell_area_code, :cell_prefix, :cell_line)
  end
end