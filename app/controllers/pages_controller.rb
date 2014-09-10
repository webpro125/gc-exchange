class PagesController < ApplicationController
  before_action :authenticate_consultant!, except: :home

  def home
    if current_consultant
      render :consultant
    end
  end

  def consultant
  end
end
