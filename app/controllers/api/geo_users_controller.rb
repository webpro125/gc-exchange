class Api::GeoUsersController < ApplicationController
  respond_to :json
  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    @consultants = Consultant.approved.includes(:user, :address, :project_histories => [:positions]).where("addresses.latitude is not null").references(:address)
  end
end
