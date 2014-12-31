require 'spec_helper'

describe PagesController do

  describe 'not logged in' do
    describe 'GET "home"' do
      it 'renders "home"' do
        get :home
        expect(response).to render_template :home
      end
    end

    describe 'GET "company_learn_more"' do
      before do
        get :company_learn_more
      end

      it { should render_with_layout(:learn_more) }
    end

    describe 'GET "consultant_learn_more"' do
      before do
        get :consultant_learn_more
      end

      it { should render_with_layout(:learn_more) }
    end
  end
end
