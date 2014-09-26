require 'spec_helper'

describe CompanyMailer do
  let(:sales_lead) { FactoryGirl.create(:sales_lead) }
  let(:mail) { CompanyMailer.company_registration_request(sales_lead) }

  describe 'Company Registration Request' do
    before do
      CompanyMailer.company_registration_request(sales_lead).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns sales_lead' do
      expect(mail.body.encoded).to match(sales_lead.email)
    end
  end
end
