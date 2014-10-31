class PagesController < ApplicationController
  before_action :authenticate_consultant!, only: :consultant
  before_action :authenticate_user!, only: :user

  def home
    render :consultant if current_consultant
  end

  def consultant
  end

  def user
  end
end
