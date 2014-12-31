class ConsultantMailer < ActionMailer::Base
  PROVISION_AGREE = 'Agreement for the Provision of Consulting Services and Service Activation.pdf'
  INDEPENDENT_AGREE = 'Independent Contractor and Service Activation Agreement.pdf'

  def send_contract(consultant_id)
    @consultant = Consultant.find(consultant_id)

    attachments[INDEPENDENT_AGREE] = File.read("#{Rails.root}/public/#{INDEPENDENT_AGREE}")

    mail(subject: 'GCES Consultant Agreements', to: @consultant.email)
  end
end
