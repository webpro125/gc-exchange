class ConsultantController < ApplicationController
  before_action :authenticate_consultant!
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  private

  def pundit_user
    current_consultant
  end
end
