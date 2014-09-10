class PagesController < ApplicationController
  before_action :authenticate_consultant!, except: :home

  def home
    render :consultant if current_consultant
  end

  def consultant
  end
end
