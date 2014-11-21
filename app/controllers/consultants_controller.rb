class ConsultantsController < CompanyController
  before_action :load_and_authorize_consultant, only: [:approve, :reject, :show]
  skip_before_action :authenticate_user!, only: :show

  def index
    @consultants = policy_scope(Consultant).page(params[:page])
    authorize @consultants
  end

  def approve
    if @consultant.approvable?
      @consultant.approved_status = ApprovedStatus.approved
    end

    if @consultant.changed? && @consultant.save
      redirect_to consultants_path, notice: t('controllers.consultant.approve.success')
    else
      redirect_to consultant_path(@consultant), notice: t('controllers.consultant.approve.fail')
    end
  end

  def show
  end

  def reject
    if @consultant.rejectable?
      @consultant.approved_status = ApprovedStatus.rejected
    end

    if @consultant.changed? && @consultant.save
      redirect_to consultants_path, notice: t('controllers.consultant.reject.success')
    else
      redirect_to consultant_path(@consultant), notice: t('controllers.consultant.reject.fail')
    end
  end

  private

  def load_and_authorize_consultant
    @consultant = Consultant.find(params[:id])
    authorize @consultant
  end
end
