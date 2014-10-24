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
    @company.destroy
    redirect_to companies_url, notice: t('controllers.company.destroy.success')
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
end
