class RaReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project_agreement

  def new
    @new_design = true
    @agreement = @project_agreement.build_ra_project_agreement
    authorize @agreement
  end

  def create
    @new_design = true
    @agreement = @project_agreement.build_ra_project_agreement(agreement_params)
    @agreement.status = 'reject' if params[:reject_draft]
    @agreement.user_id = current_user.id

    authorize @agreement

    # @agreement.consultant_id = current_user.consultant.id
    if @agreement.save
      ProjectAgreementMailer.delay.ra_reviewed_draft(@agreement, current_user)
      redirect_to project_agreements_path, notice: t('controllers.ra_reviews.create.accept')
    else render :new
    end

  end
  private

  def load_project_agreement
    @project_agreement = ProjectAgreement.find(params[:project_agreement_id])
    @project = @project_agreement.project
  end

  def agreement_params
    params.require(:ra_project_agreement).permit(:project_name_agreement, :project_name_reason, :project_period_agreement,
                                              :project_period_reason, :consultant_location_agreement, :consultant_location_reason, :travel_authorization_agreement,
                                              :travel_authorization_reason, :consultant_rate_agreement, :consultant_rate_reason, :sow_agreement, :sow_reason)
  end
end
