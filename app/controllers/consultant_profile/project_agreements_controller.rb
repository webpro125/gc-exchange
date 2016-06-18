class ConsultantProfile::ProjectAgreementsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project

  def index

  end

  def new
    @new_design = true
    @agreement = @project.build_project_agreement
    authorize @agreement
  end

  def create
    @new_design = true
    @agreement = @project.build_project_agreement(agreement_params)
    @agreement.status = 'reject' if params[:reject_draft]

    authorize @agreement

    @agreement.consultant_id = current_user.consultant.id
    if @agreement.save

      ProjectAgreementMailer.consultant_reviewed_draft(@agreement, current_user).deliver
      redirect_to consultant_profile_projects_path, notice: t('controllers.project_agreements.create.accept')
    else render :new
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
    redirect_to consultant_profile_projects_path, alert: 'You already submitted' if @project.project_agreement.present?
  end

  def agreement_params
    params.require(:project_agreement).permit(:project_name_agreement, :project_name_reason, :project_period_agreement,
      :project_period_reason, :consultant_location_agreement, :consultant_location_reason, :travel_authorization_agreement,
      :travel_authorization_reason, :consultant_rate_agreement, :consultant_rate_reason, :sow_agreement, :sow_reason)
  end
end
