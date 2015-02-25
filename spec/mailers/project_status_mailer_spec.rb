require 'spec_helper'

describe ProjectStatusMailer do
  let!(:project) { FactoryGirl.create(:project) }

  before do
    ActionMailer::Base.deliveries = []
  end

  describe 'GCES Agreed to Terms' do
    let(:mail) { ProjectStatusMailer.gces_agreed_to_terms(project) }

    before do
      ProjectStatusMailer.gces_agreed_to_terms(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns user email' do
      expect(mail.to).to eq([project.user.email])
    end
  end

  describe 'Consultant Not Interested' do
    let(:mail) { ProjectStatusMailer.consultant_not_interested(project) }

    before do
      ProjectStatusMailer.consultant_not_interested(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns user email' do
      expect(mail.to).to eq([project.user.email])
    end
  end

  describe 'Consultant Agreed to Terms' do
    let(:mail) { ProjectStatusMailer.consultant_agreed_to_terms(project) }

    before do
      ProjectStatusMailer.consultant_agreed_to_terms(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns user email' do
      expect(mail.to).to eq([project.consultant.email])
    end
  end

  describe 'Consultant Rejected Terms' do
    let(:mail) { ProjectStatusMailer.consultant_rejected_terms(project) }

    before do
      ProjectStatusMailer.consultant_rejected_terms(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns user email' do
      expect(mail.to).to eq([project.user.email])
    end
  end

  describe 'Consultant Hired' do
    let(:mail) { ProjectStatusMailer.consultant_hired(project) }

    before do
      ProjectStatusMailer.consultant_hired(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns user email' do
      expect(mail.to).to eq([project.consultant.email])
    end
  end

  describe 'Company Not Pursuing' do
    let(:mail) { ProjectStatusMailer.company_not_pursuing(project) }

    before do
      ProjectStatusMailer.company_not_pursuing(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns consultant email' do
      expect(mail.to).to eq([project.consultant.email])
    end
  end

  describe 'Company Agreed to Terms' do
    let(:mail) { ProjectStatusMailer.company_agreed_to_terms(project) }

    before do
      ProjectStatusMailer.company_agreed_to_terms(project).deliver
    end

    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'assigns consultant email' do
      expect(mail.to).to eq([project.user.email])
    end
  end
end
