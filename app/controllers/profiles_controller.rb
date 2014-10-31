class ProfilesController < ApplicationController
  before_filter :load_and_authorize_consultant, only: [:show]

  def show
  end

  private

  def load_and_authorize_consultant
    @consultant = Consultant.find(params[:id])
    authorize @consultant
  end
end
