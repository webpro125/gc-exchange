require 'spec_helper'

describe PagesController do

  describe 'not logged in' do
    describe 'GET "home"' do
      it 'renders "home"' do
        get :home
        expect(response).to render_template :home
      end
    end

    describe 'GET "about_us"' do
      before do
        get :about_us
      end

      it { should render_with_layout(:landing_page) }
      it { should render_template :about_us }
    end

    describe 'GET "contractor_benefits"' do
      before do
        get :contractor_benefits
      end

      it { should render_with_layout(:landing_page) }
      it { should render_template :contractor_benefits }
    end

    describe 'GET "consultant_benefits"' do
      before do
        get :consultant_benefits
      end

      it { should render_with_layout(:landing_page) }
      it { should render_template :consultant_benefits }
    end

    describe 'GET "contact_us"' do
      before do
        get :contact_us
      end

      it { should render_with_layout(:landing_page) }
      it { should render_template :contact_us }
    end
  end
end
