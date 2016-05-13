class Admin::CompanyController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!, except: [:autocomplete_user_email]
end