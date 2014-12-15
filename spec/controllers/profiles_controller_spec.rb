require 'spec_helper'

describe ProfilesController do

  describe 'logged in' do
    before do
      sign_in user
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }

    describe 'GET "consultant"' do
      it 'renders "consultant"' do
        get :consultant
        expect(response).to render_template :consultant
      end
    end

    describe 'GET show' do
      before do
        get :show
      end

      it { should_not redirect_to(new_user_session_path) }
      it { should render_template(:show) }
      it { should respond_with(200) }
    end

    describe 'GET edit' do
      before do
        get :edit
      end

      it { should_not redirect_to(new_user_session_path) }
      it { should render_template(:edit) }
      it { should respond_with(200) }

      it 'assigns @form' do
        expect(assigns(:form)).to be_a(EditConsultantForm)
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the profile' do
          EditConsultantForm.any_instance.should_receive(:validate).with('first_name' => 'New Name')
          put :update, consultant: { first_name: 'New Name' }
        end

        it 'updates the profile' do
          allow_any_instance_of(EditConsultantForm).to receive(:validate) { true }
          EditConsultantForm.any_instance.should_receive(:save)
          put :update, consultant: { first_name: 'New Name' }
        end

        describe do
          before do
            allow_any_instance_of(EditConsultantForm).to receive(:validate) { true }
            allow_any_instance_of(EditConsultantForm).to receive(:save) { true }
            put :update, consultant: { first_name: 'New Name' }
          end

          it 'assigns the form as @form' do
            assigns(:form).should be_a(EditConsultantForm)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(consultant_root_path) }
        end
      end

      describe 'with invalid params' do
        before do
          allow_any_instance_of(EditConsultantForm).to receive(:validate) { false }
          put :update, consultant: { first_name: '' }
        end

        it 'assigns the form as @form' do
          assigns(:form).should be_a(EditConsultantForm)
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:edit) }
      end
    end
  end
end
