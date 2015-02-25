class ProjectsController < ApplicationController
  before_action :auth_a_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_consultant, only: [:new, :create]

  # GET /projects
  def index
    @projects    = pundit_user.projects.page(params[:page])
    @consultants = Consultant.recent
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = pundit_user.projects.build
    @form    = ProjectForm.new(@project)

    authorize @project
  end

  # GET /projects/1/edit
  def edit
    @form = ProjectForm.new(@project)
  end

  # POST /projects
  def create
    @project            = current_user.projects.build
    @project.consultant = @consultant

    authorize @project

    @form = ProjectForm.new(@project)

    if @form.validate(project_params) && @form.save
      redirect_to @project, notice: 'Engagement Offer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    @form = ProjectForm.new(@project)

    if @form.validate(project_params) && @form.save
      redirect_to @project, notice: 'Engagement Offer was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def set_consultant
    @consultant = Consultant.find(params[:consultant_id])
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.require(:project).permit(:travel_authorization_id, :proposed_start, :proposed_end,
                                    :proposed_rate, :project_name, :project_location)
  end
end
