require 'spec_helper'

describe PagesController do

  describe 'not logged in' do
    describe 'GET "home"' do
      it 'renders "home"' do
        get :home
        expect(response).to render_template :home
      end
    end

    describe 'GET "consultant"' do
      it 'redirects to new_consultant_session' do
        get :consultant
        expect(response).to redirect_to new_consultant_session_path
      end
    end
  end

  describe 'logged in as consultant' do
    before do
      sign_in FactoryGirl.create(:confirmed_consultant)
    end

    describe 'GET "consultant"' do
      it 'renders "consultant"' do
        get :consultant
        expect(response).to render_template :consultant
      end
    end
  end
end
