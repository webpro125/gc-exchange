class UpdateContractsController < ApplicationController
  before_action :authenticate_consultant!

  def new
    @form = EditConsultantForm.new current_consultant
  end

  def update
    current_consultant.contract_effective_date = DateTime.now
    current_consultant.contract_version = Consultant::CURRENT_CONTRACT_VERSION
    @form = EditConsultantForm.new current_consultant

    if @form.validate(params.require(:consultant))
      @form.save
      redirect_to after_sign_in_path_for(current_consultant), notice: "Thank you for updating your contract."
    else
      render :show
    end
  end
end
