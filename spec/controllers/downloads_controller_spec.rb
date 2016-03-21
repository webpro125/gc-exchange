require 'spec_helper'
require 'byebug'

describe DownloadsController do
  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'download_resume' do
        # let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }
        let(:user) { FactoryGirl.create(:user, :resume_approved) }
        before do
          user.consultant.save!
          get :download_resume, id: user.consultant.id
        end

        it { should redirect_to(user.consultant.resume.url) }
      end
    end

    describe 'as Owner' do
      let(:user) { FactoryGirl.create(:user, :as_owner) }

      describe 'download_resume' do
        # let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }
        let(:user) { FactoryGirl.create(:user, :resume_approved) }

        before do
          user.consultant.save!
          get :download_resume, id: user.consultant.id
        end
        it { should redirect_to(user.consultant.resume.url) }
      end
    end
  end

  describe 'logged out' do
    describe 'download_resume' do
      # let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }
      let(:user) { FactoryGirl.create(:user, :resume_approved) }

      before do
        allow_any_instance_of(User).to receive(:resume_url) { 'BOOM' }
        get :download_resume, id: user.consultant.id
      end

      it { should redirect_to(new_sales_lead_path) }
    end
  end
end
