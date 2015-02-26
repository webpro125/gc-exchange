require 'spec_helper'

describe ChangePasswordsController do
  let(:valid_attributes) do
    { password: 'password123', password_confirmation: 'password123' }
  end
  let(:current_pass) do
    { current_password: 'password' }
  end

  let(:user) { FactoryGirl.create(:user, :with_company) }

  describe 'logged in' do
    before do
      sign_in user
    end

    # describe 'password strong_params' do
    #   let!(:valid_attributes) do
    #     { password: 'password123', password_confirmation: 'password123' }
    #   end
    #   it do
    #     User.any_instance.stub(:current_password).and_return(true)
    #     should permit(:password, :password_confirmation).for(:update)
    #   end
    # end

    describe 'as user' do
      describe 'GET edit' do
        before do
          get :edit
        end

        it { should_not redirect_to(root_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }
      end

      describe 'PUT update' do
        describe 'with invalid params' do
          before do
            put :update, user: valid_attributes, user: current_pass
          end

          it { should_not redirect_to(root_path) }
          it { should render_template(:edit) }
          it { should respond_with(200) }
        end

        describe 'with valid params' do
          before do
            put :update, user: valid_attributes, user: current_pass
          end

          # it { should redirect_to(root_path) }
          # it { should_not render_template(:edit) }
          it { should respond_with(200) }
        end
      end
    end
  end
end
