class PagesController < ApplicationController
  skip_before_filter :authenticate_consultant!, only: :home

  def home
    render :consultant if current_consultant
  end

  def consultant
  end
end
