class ProjectsController < ApplicationController
  before_action :auth_a_user!
  before_action :set_project, except: [:index, :new, :create]
  before_action :set_consultant, only: [:new, :create]
  before_action :consultants

  # GET /projects
  def index
    @projects = pundit_user.projects.page(params[:page])
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @new_design = true
    @project = pundit_user.projects.build
    @project.build_work_location_address
    @form    = ProjectForm.new(@project)

    authorize @project
  end

  # GET /projects/1/edit
  def edit
    @form = ProjectForm.new(@project)
  end

  # POST /projects
  def create
    @new_design = true
    @project            = pundit_user.projects.build
    @project.build_work_location_address
    # @project.consultant = @consultant

    authorize @project

    @form = ProjectForm.new(@project)
    @form.consultant_id = @consultant.id


    if @form.validate(project_params) && @form.save
      @consultant = @project.consultant
      # send notification sms to consultant for this offer
      # host_url = request.host || "drake.gces.staging.c66.me"
      # off_url = host_url + '/offers/' + @project.id.to_s
      # message = 'You just recieved an offer to support a consulting project assignment.
      #         Please login to GCES to view your offer: ' + off_url
      # send_sms(@consultant.phones.first.number.to_s, message, @consultant) unless @consultant.phones.blank?

      redirect_to @project, notice: 'Engagement Offer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    @form = ProjectForm.new(@project)

    if @form.validate(project_params) && ProjectSetStatus.new(@form).offer_and_save
      redirect_to @project, notice: 'Engagement Offer was successfully updated.'
    else
      render :edit
    end
  end

  def not_interested
    if ProjectSetStatus.new(@project).not_interested_and_save
      redirect_to projects_path
    else
      render :show
    end
  end

  def not_pursuing
    if ProjectSetStatus.new(@project).not_pursuing_and_save
      redirect_to projects_path
    else
      render :show
    end
  end

  def agree_to_terms
    if ProjectSetStatus.new(@project).agree_to_terms_and_save
      redirect_to projects_path
    else
      render :show
    end
  end

  def reject_terms
    if ProjectSetStatus.new(@project).under_revision_and_save
      redirect_to projects_path
    else
      render :show
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
    params.require(:project).permit(:consultant_id, :travel_authorization, :proposed_start, :proposed_end,
                                    :proposed_rate, :project_name, :consultant_location, :sow,
                                    :rate_approve, :summarize_statement,
      work_location_address_attributes:[:address1, :address2, :city, :st, :zip_code])
  end

  def consultants
    @consultants = Consultant.recent
  end
end
