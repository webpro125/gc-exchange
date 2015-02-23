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

          # it 'updates the profile' do
          #   allow_any_instance_of(EditConsultantForm).to receive(:validate) { true }
          #   EditConsultantForm.any_instance.should_receive(:save)
          #   put :update, consultant: { first_name: 'New Name' }
          # end
          #
          # describe do
          #   before do
          #     allow_any_instance_of(EditConsultantForm).to receive(:validate) { true }
          #     allow_any_instance_of(EditConsultantForm).to receive(:save) { true }
          #     put :update, consultant: { first_name: 'New Name' }
          #   end
          #
          #   it 'assigns the form as @form' do
          #     assigns(:form).should be_a(EditConsultantForm)
          #   end
          #
          #   it { should_not redirect_to(new_user_session_path) }
          #   it { should redirect_to(consultant_root_path) }
        end
      end

      # describe 'with invalid params' do
      #   before do
      #     put :update, user: { password: '123456',
      #                          password_confirmation: '12345678'
      #                }
      #   end
      #
      #   it 'assigns the form as @form' do
      #     assigns(:form)
      #   end
      #
      #   it { should_not redirect_to(root_path) }
      #   it { should render_template(:edit) }
      # end
    end
  end
end
