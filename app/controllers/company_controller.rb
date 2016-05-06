class CompanyController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :registration, :do_registration]
  after_action :verify_policy_scoped, only: :index
end
