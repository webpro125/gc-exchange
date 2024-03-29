class SalesLeadsController < ApplicationController
  def new
    @sales_lead = SalesLead.new
  end

  def create
    @sales_lead = SalesLead.new(sales_lead_params)

    if @sales_lead.save
      CompanyMailer.company_registration_request(@sales_lead).deliver
      flash[:success] = I18n.t('controllers.sales_lead.create.success')

      # 'Message was successfully sent'
      redirect_to company_welcome_path
    else
      render :new
    end
  end

  private

  def sales_lead_params
    params.require(:sales_lead).permit(:first_name, :last_name, :company_name,
                                       :phone_number, :email, :message)
  end
end
