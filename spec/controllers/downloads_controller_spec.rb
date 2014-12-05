require 'spec_helper'

describe DownloadsController do
  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'download_resume' do
        let!(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          get :download_resume, id: consultant.id
        end

        it { should_not redirect_to(root_path) }
      end
    end

    describe 'as Owner' do
      let(:user) { FactoryGirl.create(:user, :as_owner) }

      describe 'download_resume' do
        let!(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          get :download_resume, id: consultant.id
        end
        it { should_not redirect_to(root_path) }
      end
    end
  end

  describe 'logged out' do
    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'download_resume' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          sign_out user
          allow_any_instance_of(Consultant).to receive(:resume_url) { 'BOOM' }
          get :download_resume, id: consultant.id
        end

        it { should redirect_to(root_path) }
      end
    end
  end
end
