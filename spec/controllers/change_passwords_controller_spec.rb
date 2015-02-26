require 'spec_helper'

describe ChangePasswordsController do
  let(:valid_attributes) do
    { password: 'password123', password_confirmation: 'password123', current_password: 'password' }
  end

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

        it { should render_template(:edit) }
        it { should respond_with(200) }
      end

      describe 'PUT update' do
        describe 'with invalid params' do
          before do
            put :update, user: { current_password: 'nooooo' }
          end

          it { should render_template(:edit) }
          it { should respond_with(200) }
        end

        describe 'with valid params' do
          before do
            allow_any_instance_of(User).to receive(:valid_password?) { true }
            put :update, user: valid_attributes
          end

          it { should redirect_to(root_path) }
          it { should_not render_template(:edit) }
        end
      end
    end
  end
end
