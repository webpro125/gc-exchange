class Api::GeoUsersController < ApplicationController
  respond_to :json
  def index
    @consultants = Consultant.approved.includes(:user, :address, :project_histories => [:positions]).where("addresses.latitude is not null").references(:address)
  end
end
