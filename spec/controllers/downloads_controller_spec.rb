require 'spec_helper'

describe DownloadsController do
  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'download_resume' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          consultant.save!
          get :download_resume, id: consultant.id
        end

        it { should redirect_to(consultant.resume.url) }
      end
    end

    describe 'as Owner' do
      let(:user) { FactoryGirl.create(:user, :as_owner) }

      describe 'download_resume' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          consultant.save!
          get :download_resume, id: consultant.id
        end
        it { should redirect_to(consultant.resume.url) }
      end
    end
  end

  describe 'logged out' do
    describe 'download_resume' do
      let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

      before do
        allow_any_instance_of(Consultant).to receive(:resume_url) { 'BOOM' }
        get :download_resume, id: consultant.id
      end

      it { should redirect_to(new_sales_lead_path) }
    end
  end
end
