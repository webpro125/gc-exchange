class UsersController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create_consultant
    redirect_to consultant_root_path
  end
end