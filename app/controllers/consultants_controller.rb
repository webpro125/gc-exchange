class ConsultantsController < CompanyController
  before_action :load_and_authorize_consultant, only: [:approve, :reject, :show]

  def index
    @consultants = policy_scope(Consultant).page(params[:page])
    authorize @consultants
  end

  def approve
    if @consultant.pending_approval? || @consultant.rejected?
      @consultant.approved_status = ApprovedStatus.approved
    end

    if @consultant.changed? && @consultant.save
      redirect_to consultants_path, notice: t('controllers.consultant.approve.success')
    else
      redirect_to profile_path(@consultant), notice: t('controllers.consultant.approve.fail')
    end
  end

  def reject
    if @consultant.pending_approval? || @consultant.approved?
      @consultant.approved_status = ApprovedStatus.rejected
    end

    if @consultant.changed? && @consultant.save
      redirect_to consultants_path, notice: t('controllers.consultant.reject.success')
    else
      redirect_to profile_path(@consultant), notice: t('controllers.consultant.reject.fail')
    end
  end

  private

  def load_and_authorize_consultant
    @consultant = Consultant.find(params[:id])
    authorize @consultant
  end
end
