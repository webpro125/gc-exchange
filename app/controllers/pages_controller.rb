class PagesController < ApplicationController
  def home
    @sales_lead = SalesLead.new
    @consultant = Consultant.new

    render layout: 'landing_page'
  end

  def terms_of_service
  end

  def privacy_policy
  end

  def consultant_learn_more
    render layout: 'learn_more'
  end

  def company_learn_more
    render layout: 'learn_more'
  end

  def health_check
    render text: DateTime.now
  end
end
