class UpdateContractsController < ApplicationController
  before_action :authenticate_consultant!

  def skip
    session[:skip_update_contract] = true
    redirect_to after_sign_in_path_for(current_consultant), notice: "Please remember to update your contract later."
  end

  def new
    @contract = Contract.for_consultant(current_consultant)
    @contract.updating_contract = true
    @form = EditConsultantForm.new current_consultant
  end

  def update
    current_consultant.contract_effective_date = DateTime.now
    current_consultant.contract_version = Consultant::CURRENT_CONTRACT_VERSION
    @form = EditConsultantForm.new current_consultant
    @form.save
    redirect_to after_sign_in_path_for(current_consultant), notice: "Thank you for updating your contract."
  end
end
