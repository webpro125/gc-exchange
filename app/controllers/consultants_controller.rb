class ConsultantsController < ApplicationController
  before_action :load_and_authorize_consultant, only: [:approve, :reject, :show, :contract]
  skip_before_action :authenticate_user!, only: [:show, :contract]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ConsultantsDatatable.new(view_context) }
      format.csv  { send_data policy_scope(Consultant).to_csv }
      format.xls  { send_data policy_scope(Consultant).to_csv(col_sep: "\t") }
    end
    @consultants = policy_scope(Consultant).page(params[:page])
    authorize @consultants
  end

  def approve
    if ConsultantSetStatus.new(@consultant).approve_and_save

      host_url = request.host || "drake.gces.staging.c66.me"
      profile_url = host_url + '/profile/edit'
      message = 'Your profile has been approved by GCES and is viewable by our Client Companies.
                  Please remember to keep your profile updated at: ' + profile_url
      send_sms(@consultant.phones.first.number.to_s, message) unless @consultant.phones.blank?

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
    @contract = Contract.for_consultant(@consultant)
    render pdf: 'contract'
  end

  private

  def load_and_authorize_consultant
    @consultant = Consultant.find(params[:id])
    authorize @consultant
  end
end
