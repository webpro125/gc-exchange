class PagesController < ApplicationController
  skip_before_filter :authenticate_consultant!, only: :home

  def home
  end

  def consultant
  end
end
