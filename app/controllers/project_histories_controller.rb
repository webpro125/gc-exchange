class ProjectHistoriesController < ConsultantController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  def index
    @projects = policy_scope(current_consultant.project_histories)
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = current_consultant.project_histories.build
    authorize @project
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = current_consultant.project_histories.build(project_params)
    authorize @project

    if @project.save
      flash[:success] = t('controllers.project_history.create.success')
      redirect_to project_histories_path
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      flash[:success] = t('controllers.project_history.update.success')
      redirect_to project_histories_path
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    flash[:success] = t('controllers.phone.destroy.success')

    redirect_to project_histories_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = ProjectHistory.find(params[:id])
    authorize @project
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.require(:project_history).permit(:customer_name, :client_company, :client_poc_name,
                                            :client_poc_email, :start_date, :end_date,
                                            :description, :position_id)
  end
end
