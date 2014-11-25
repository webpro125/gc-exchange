class PagesController < ApplicationController
  before_action :authenticate_consultant!, only: :consultant
  before_action :authenticate_user!, only: :user

  def home
    @sales_lead = SalesLead.new
    @consultant = Consultant.new

    render layout: 'landing_page'
  end

  def consultant
  end

  def user
  end
end
