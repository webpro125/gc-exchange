class DownloadsController < ApplicationController
  before_action :load_consultant, only: [:download_resume]

  def download_resume
    if user_signed_in? || consultant_signed_in?
      if Rails.env.development?
        redirect_to "/#{@consultant.resume_url}"
      else
        redirect_to @consultant.resume_url
      end
    else
      redirect_to new_sales_lead_path
    end
  end

  private

  def load_consultant
    @consultant = Consultant.find(params[:id])
  end
end
