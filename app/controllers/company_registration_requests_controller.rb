class CompanyRegistrationRequestsController < ApplicationController
  def new
    @company_registration_request = CompanyRegistrationRequest.new
  end

  def create
    @company_registration_request =
        CompanyRegistrationRequest.new(params[:company_registration_request])

    if @company_registration_request.valid?
      CompanyMailer.company_registration_request(@company_registration_request).deliver
      flash[:success] = 'Message was successfully sent'
      redirect_to root_path
    else
      render :new
    end
  end
end
