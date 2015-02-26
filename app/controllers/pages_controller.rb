class PagesController < ApplicationController
  def home
    @sales_lead = SalesLead.new
    @consultant = Consultant.new

    render layout: 'landing_page'
  end

  def about_us
    render layout: 'landing_page'
  end

  def contractor_benefits
    render layout: 'landing_page'
  end

  def how_we_do_it
    render layout: 'landing_page'
  end

  def consultant_benefits
    render layout: 'landing_page'
  end

  def contact_us
    render layout: 'landing_page'
  end

  def terms_of_service
  end

  def privacy_policy
  end

  def health_check
    render text: DateTime.now
  end

  def profile_completed
  end
end
