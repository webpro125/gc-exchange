class Admin::BaseController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!
end