class PagesController < ApplicationController
  skip_before_filter :authenticate_consultant!, only: :home

  def home
    if current_consultant
      render :consultant
    end
  end

  def consultant
  end
end
