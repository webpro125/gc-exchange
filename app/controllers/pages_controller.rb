class PagesController < ApplicationController
  before_action :authenticate_consultant!, only: :consultant
  before_action :authenticate_user!, only: :user

  def home
    @sales_lead = SalesLead.new
    @consultant = Consultant.new

    render layout: 'landing_page'
  end

  def user
  end

  def terms_of_service
  end

  def consultant_learn_more
    render layout: 'learn_more'
  end

  def company_learn_more
    render layout: 'learn_more'
  end
end
