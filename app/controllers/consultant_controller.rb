class ConsultantController < ApplicationController
  before_action :authenticate_consultant!
  before_action :consultant_wizard_redirect
  before_action :current_contract_redirect
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  private

  def pundit_user
    current_consultant
  end

  def consultant_wizard_redirect
    return unless current_consultant.present? &&
                  current_consultant.wizard_step != Wicked::FINISH_STEP.to_s

    redirect_to create_profile_path(current_consultant.wizard_step || Wicked::FIRST_STEP)
    false
  end

  def current_contract_redirect
    if current_consultant.contract_signed? && !current_consultant.current_contract? && session[:skip_update_contract].blank?
      redirect_to new_update_contract_path
    end
  end
end
