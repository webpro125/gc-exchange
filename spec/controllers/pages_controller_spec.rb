require 'spec_helper'

describe PagesController do

  describe 'not logged in' do
    describe 'GET "home"' do
      it 'renders "home"' do
        get :home
        expect(response).to render_template :home
      end
    end
  end
end
