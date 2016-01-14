class ContractUpdated < ActionMailer::Base
  def notify(consultant)
    @consultant = consultant

    mail to: consultant.email,
      subject: "Recently Updated Contract on GCES"
  end
end
