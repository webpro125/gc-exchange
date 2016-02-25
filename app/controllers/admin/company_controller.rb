class Admin::CompanyController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

end