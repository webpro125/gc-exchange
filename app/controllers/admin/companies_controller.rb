class Admin::CompaniesController < Admin::CompanyController
  before_action :set_company, except: [:index, :new, :create, :autocomplete_user_email,
                                   :destroy_account_manager, :registration_requests]
  add_breadcrumb 'Companies', :admin_companies_path
  before_action :authenticate_admin!, except: [:autocomplete_user_email]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]
  helper_method :mailbox, :conversation

  def index
    @companies = Company.all
  end

  def new
    add_breadcrumb 'New Company'
    @company = Company.new
    # @company.build_owner
  end

  def create
    @company = Company.new(company_create_params)

    generated_password = ''

    if @company.valid?

      generated_password = Devise.friendly_token.first(8) if User.where(email:@company.email).first.blank?

      user = User.where(email:@company.email).first_or_create! do |user|
        user.password = generated_password
        user.first_name = @company.first_name
        user.last_name = @company.last_name
        user.skip_confirmation!
      end
      @company.owner_id = user.id
    end

    respond_to do |format|
      if @company.save

        CompanyMailer.company_created(@company, generated_password).deliver

        sms_content = 'Thank you for signing a contract with GCES.
                      Please log into the site and start assigning Business Unit Account Managers.'

        send_sms(@company.cell_phone, sms_content) unless @company.cell_phone.blank?

        format.html { redirect_to admin_companies_path, notice: t('controllers.company.create.success') }
        format.json { render json: admin_companies_path, status: :created, location: @company }
      else
        format.html { render action: "new", notice: @company.errors }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    add_breadcrumb @company.company_name
    # @users = @company.users
  end

  def update
    respond_to do |format|
      if @company.update(company_create_params)
        format.html { redirect_to admin_companies_path, notice: t('controllers.company.update.success') }
        format.json { render json: admin_companies_path, status: :created, location: @company }
      else
        format.html { render action: "edit", notice: @company.errors }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @company.destroy
    redirect_to admin_companies_path, notice: t('controllers.company.destroy.success')
  end

  def invite_account_manager
    @account_managers = @company.account_managers
    account_manager = @company.account_managers.build

    @form = InviteAccountManagerForm.new(account_manager)

    add_breadcrumb 'Invite Account Manager'
  end

  def send_invite
    # @company.build_invite_user(send_invite_params)
    @account_managers = @company.account_managers
    account_manager = @company.account_managers.build
    @form = InviteAccountManagerForm.new(account_manager)
    @form.email_content = AccountManager::DEFAULT_EMAIL_CONTENT
    random_token = SecureRandom.hex(32)

    if @form.validate(send_invite_params)
      if User.where(email:@form.email).first.blank?
        generated_password = Devise.friendly_token.first(8)
      else
        generated_password = ''
      end
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

      CompanyMailer.invite_account_manager(AccountManager.find(@form.id), generated_password).deliver
      # 'Message was successfully sent'
      redirect_to admin_companies_path, notice: I18n.t('controllers.sales_lead.create.success')
    else
      render action: "invite_account_manager", notice: @company.errors
    end
  end

  def destroy_account_manager
    am = AccountManager.find(params[:id])
    company = am.company
    if am.destroy
      redirect_to invite_account_manager_admin_company_path(company), notice: 'Destroyed Successfully.'
    else
      render :invite_account_manager
    end
  end

  def registration_requests
   @requests = RequestedCompany.order(created_at: :desc)
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def company_create_params
    params.require(:company).permit(:company_name, :work_phone, :cell_phone, :contract_start, :contract_end, :owner_id,
                                    :first_name, :last_name, :email, :contract, :gsc, :address)
  end

  def company_update_params
    params.require(:company).permit(:company_name, :owner_id)
  end

  def send_invite_params
    # params.require(:company).permit(account_managers_attributes: [:first_name, :last_name,
    #                                                                   :email])
    params.require(:account_manager).permit(:first_name, :last_name, :email)
  end

  def mailbox
    @mailbox ||= current_admin.mailbox
  end

  def conversation
    @conversation ||= current_admin.mailbox.conversations.find(params[:id])
  end
end
