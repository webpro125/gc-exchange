require 'spec_helper'

describe ChangePasswordsController do
  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }
      describe 'GET edit' do
        before do
          get :edit
        end

        it { should_not redirect_to(root_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }
      end

      describe 'PUT update' do
        describe 'with valid params' do
          it 'updates the password' do
            put :update, user: { password: 'password1',
                                 password_confirmation: 'password1'
                       }
          end

          it 'assigns @form' do
            expect(assigns(:form))
          end
        end
      end
    end
  end
end
