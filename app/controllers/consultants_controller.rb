class ConsultantsController < CompanyController
  before_action :load_and_authorize_consultant, only: [:approve, :reject, :show, :contract]
  skip_before_action :authenticate_user!, only: :show

  def index
    @consultants = policy_scope(Consultant).page(params[:page])
    authorize @consultants
  end

  def approve
    if ConsultantSetStatus.new(@consultant).approve_and_save
      redirect_to consultants_path, notice: t('controllers.consultant.approve.success')
    else
      redirect_to consultant_path(@consultant), notice: t('controllers.consultant.approve.fail')
    end
  end

  def show
  end

  def reject
    if ConsultantSetStatus.new(@consultant).reject_and_save
      redirect_to consultants_path, notice: t('controllers.consultant.reject.success')
    else
      redirect_to consultant_path(@consultant), notice: t('controllers.consultant.reject.fail')
    end
  end

  def contract
    respond_to do |format|
      format.pdf do
        render pdf: 'contract'
      end
    end
  end

  private

  def load_and_authorize_consultant
    @consultant = Consultant.find(params[:id])
    authorize @consultant
  end
end
