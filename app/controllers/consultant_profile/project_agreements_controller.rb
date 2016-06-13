class ConsultantProfile::ProjectAgreementsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project

  def new
    @new_design = true
    @agreement = @project.build_project_agreement
    authorize @agreement
  end

  def create
    @new_design = true
    @agreement = @project.build_project_agreement(agreement_params)
    authorize @agreement
    @agreement.consultant_id = current_user.consultant.id
    if @agreement.save
      redirect_to consultant_profile_projects_path
    else render :new
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def agreement_params
    params.require(:project_agreement).permit(:project_name_agreement, :project_name_reason, :project_period_agreement,
      :project_period_reason, :consultant_location_agreement, :consultant_location_reason, :travel_authorization_agreement,
      :travel_authorization_reason, :consultant_rate_agreement, :consultant_rate_reason, :sow_agreement, :sow_reason)
  end
end
