class ProjectAgreementsController < ApplicationController
  before_action :authenticate_user!
  # before_action :load_project_agreements, only: [:index]

  def index
    @project_agreements = policy_scope(ProjectAgreement)
  end

  def new
  end

end
