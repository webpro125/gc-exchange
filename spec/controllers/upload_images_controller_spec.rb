require 'spec_helper'

describe UploadImagesController do
  describe 'logged in' do
    before do
      sign_in user
    end

    let(:user) { FactoryGirl.create(:user, :wicked_finish) }
    describe 'GET new' do
      before do
        get :new, consultant_id: user.consultant
      end

      it { should_not redirect_to(consultant_root_path) }
      it { should render_template(:new) }
      it { should respond_with(200) }

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of(UploadImageForm)
      end
    end

    describe 'POST create' do
      describe 'successful' do
        it 'should call validate' do
          UploadImageForm.any_instance.should_receive(:validate) { true }
          post :create, consultant_id: user.consultant.id,
                        consultant: { profile_image: fixture_file_upload('default_profile.png',
                                                                         'image/png') }
        end

        describe do
          before do
            allow_any_instance_of(UploadImageForm).to receive(:validate) { true }
            post :create, consultant_id: user.consultant.id,
                          consultant: { profile_image: fixture_file_upload('default_profile.png',
                                                                           'image/png') }
          end

          it { should redirect_to(consultant_root_path) }
        end
      end

      describe 'unsuccessful' do
        describe do
          before do
            allow_any_instance_of(UploadImageForm).to receive(:validate) { false }
            post :create, consultant_id: user.consultant.id,
                          consultant: { profile_image: fixture_file_upload('default_profile.png',
                                                                           'image/png') }
          end

          it { should render_template(:new) }
        end
      end
    end
  end
end
