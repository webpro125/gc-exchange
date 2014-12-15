require 'spec_helper'

describe UploadImagesController do
  describe 'logged in' do
    before do
      sign_in user
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }

    describe 'GET new' do
      before do
        get :new, consultant_id: user
      end

      it { should_not redirect_to(consultant_root_path) }
      it { should render_template(:new) }
      it { should respond_with(200) }

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of(UploadImageForm)
      end
    end
  end
end
