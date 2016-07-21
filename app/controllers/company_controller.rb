class CompanyController < ApplicationController
  before_action :authenticate_user!, except: [:accept_by_token]
  after_action :verify_authorized, except: [:index, :registration, :do_registration, :accept_by_token]
  after_action :verify_policy_scoped, only: :index
end
