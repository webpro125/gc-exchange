class Admin::CompaniesController < Admin::CompanyController
  def index
    @companies = Company.all
  end

  def new
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
    @company = Company.find(params[:id])
    @users = @company.users
  end

  def update
    @company = Company.find(params[:id])

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

  private

  # Only allow a trusted parameter "white list" through.
  def company_create_params
    params.require(:company).permit(:company_name, owner_attributes: [:first_name, :last_name,
                                                                      :email])
  end

  def company_update_params
    params.require(:company).permit(:company_name, :owner_id)
  end
end
