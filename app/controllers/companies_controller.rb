class CompaniesController < CompanyController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  def index
    if !current_user.gces? && current_user.owned_company.present?
      redirect_to company_path(current_user.owned_company)
    end

    @companies = policy_scope(Company.all)
  end

  # GET /companies/1
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_owner
    authorize @company
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    @company = Company.new(company_create_params)
    authorize @company

    if @company.save
      redirect_to @company, notice: t('controllers.company.create.success')
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_update_params)
      redirect_to @company, notice: t('controllers.company.update.success')
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    if @company.destroy
      redirect_to companies_url, notice: t('controllers.company.destroy.success')
    else
      redirect_to companies_url, alert: t('controllers.company.destroy.fail')
    end
  end

  # request company
  def registration
    @new_design = true
    @requested_company = RequestedCompany.new
  end

  # put request company submit
  def do_registration
    @new_design = true
    @requested_company = RequestedCompany.new(request_company_params)
    @requested_company.user_id = current_user.id
    if @requested_company.save
      email_content =
          "One User Requested Company Creation  \n
           Email: #{current_user.email}
           Full Name: #{current_user.full_name}  \n
           Company Name: #{@requested_company.company_name}
           Work Phone: #{@requested_company.work_phone}
           Cell Phone: #{@requested_company.cell_phone}
           Message: #{@requested_company.help_content}
      "
      # email_content["{full_name}"] = @requested_company.user.full_name
      Mailboxer.uses_emails = false
      Admin.all.each {|admin|
        CompanyMailer.delay.company_requested(@requested_company, admin)
        conversation = current_user.send_message(admin,
                                     email_content,
                                     Company::CREATED_EMAIL_SUBJECT).conversation
        host_url = request.host || "drake.gces.staging.c66.me"
        send_sms(admin.phone.to_s, email_content) unless admin.phone.blank?
      }
      sms_txt = @requested_company.created_email(current_user)
      send_sms(@requested_company.cell_phone, sms_txt) unless @requested_company.cell_phone.blank?
      redirect_to registration_companies_path, notice: t('controllers.company.request_register.success')
    else
      render :registration
    end
  end

  def accept_by_token
    company = Company.find_by_access_token(params[:access_token])

    raise Pundit::NotAuthorizedError if company.blank?

    sign_in(company.owner)

    company.update_attributes(access_token: '')
    redirect_to new_account_manager_path, notice: 'Please Invite Account Manager for your company'
  end
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

  # Only allow a trusted parameter "white list" through.
  def company_create_params
    params.require(:company).permit(:company_name, owner_attributes: [:first_name, :last_name,
                                                                      :email])
  end

  def company_update_params
    params.require(:company).permit(:company_name, :owner_id)
  end

  def request_company_params
    params.require(:requested_company).permit(:company_name, :help_content, :work_area_code,
          :work_prefix, :work_line, :cell_area_code, :cell_prefix, :cell_line, :work_phone_ext)
  end

end
