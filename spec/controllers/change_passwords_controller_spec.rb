require 'spec_helper'

describe ChangePasswordsController do
  let(:user) { FactoryGirl.create(:user, :with_company) }

  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as user' do
      describe 'GET edit' do
        before do
          get :edit
        end

        it { should_not redirect_to(root_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }
      end
    end
  end
end
