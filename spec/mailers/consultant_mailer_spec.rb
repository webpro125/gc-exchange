require 'spec_helper'

describe ConsultantMailer do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:mail) { ConsultantMailer.send_contract(consultant.id) }

  describe 'Company Registration Request' do
    before do
      ConsultantMailer.send_contract(consultant.id).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns sales_lead' do
      expect(mail.to).to eq([consultant.email])
    end
  end
end
