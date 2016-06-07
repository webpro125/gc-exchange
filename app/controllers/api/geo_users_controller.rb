class Api::GeoUsersController < ApplicationController
  respond_to :json
  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    if params[:q].present?
      search = Search.new(q: params[:q])
      response = Consultant.search(SearchAdapter.new(search).to_query)
      @consultants = response.records
    else
      @consultants = Consultant.approved.includes(:user, :address, :project_histories => [:positions]).where("addresses.latitude is not null").references(:address)
    end
  end
end
