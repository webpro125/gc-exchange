class Admin::CompanyController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!, except: [:autocomplete_user_email]
  autocomplete :user, :email, :full => true, :extra_data => [:first_name, :last_name]
end