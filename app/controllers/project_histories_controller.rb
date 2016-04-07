class ProjectHistoriesController < ConsultantController
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = policy_scope(current_user.consultant.project_histories.order(created_at: :desc))
  end

  # GET /projects/new
  def new
    project = current_user.consultant.project_histories.build
    project.build_phone unless project.phone
    authorize project

    @form = ProjectHistoryForm.new(project)
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    project = current_user.consultant.project_histories.build
    project.build_phone
    authorize project

    @form = ProjectHistoryForm.new(project)

    if @form.validate(project_params) && @form.save
      flash[:success] = t('controllers.project_history.create.success')
      redirect_to project_histories_path
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @form.validate(project_params) && @form.save
      flash[:success] = t('controllers.project_history.update.success')
      redirect_to project_histories_path
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    flash[:success] = t('controllers.project_history.destroy.success')

    redirect_to project_histories_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = ProjectHistory.find(params[:id])
    @project.build_phone unless @project.phone
    authorize @project

    @form = ProjectHistoryForm.new(@project)
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    if params[:project_history] && params[:project_history][:position_ids]
      params[:project_history][:position_ids].reject!(&:empty?)
    end

    params.require(:project_history)
  end
end
