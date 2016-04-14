class Admin::CompaniesController < Admin::CompanyController
  before_action :set_company, except: [:index, :new, :create]
  add_breadcrumb 'Companies', :admin_companies_path

  def index
    @companies = Company.all
  end

  def new
    add_breadcrumb 'New Company'
    @company = Company.new
    @company.build_owner
  end

  def create
    @company = Company.new(company_create_params)

    respond_to do |format|
      if @company.save
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
      if @company.update(company_update_params)
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
    add_breadcrumb 'Invite Account Manager'
    @company.build_invite_user unless @company.invite_user.present?
  end

  def send_invite
    # @company.build_invite_user(send_invite_params)
    if @company.update(send_invite_params)
      CompanyMailer.invite_account_manager(@company).deliver

      # 'Message was successfully sent'
      redirect_to admin_companies_path, notice: I18n.t('controllers.sales_lead.create.success')
    else
      render action: "invite_account_manager", notice: @company.errors
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def company_create_params
    params.require(:company).permit(:company_name, :first_name, :last_name,
                                    :phone, :contract_start, :contract_end, :owner_id)
  end

  def company_update_params
    params.require(:company).permit(:company_name, :owner_id)
  end

  def send_invite_params
    params.require(:company).permit(invite_user_attributes: [:first_name, :last_name, :email])
  end
end
