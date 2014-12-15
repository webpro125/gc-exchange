require 'spec_helper'

describe UploadResumesController do
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
        expect(assigns(:form)).to be_a_kind_of(UploadResumeForm)
      end
    end

    # describe 'POST create' do
    #   describe 'successful' do
    #     it 'should call validate' do
    #       UploadResumeForm.any_instance.should_receive(:validate) { true }
    #       put :create,
    #           consultant: { resume: fixture_file_upload('a_pdf.pdf', 'application/pdf') }
    #     end
    #
    #     describe do
    #       before do
    #         allow_any_instance_of(UploadResumeForm).to receive(:validate) { true }
    #         put :upload_resume,
    #             consultant: { resume: fixture_file_upload('a_pdf.pdf', 'application/pdf') }
    #       end
    #
    #       it { should redirect_to(consultant_root_path) }
    #     end
    #   end
    #
    #   describe 'unsuccessful' do
    #     describe do
    #       before do
    #         allow_any_instance_of(UploadResumeForm).to receive(:validate) { false }
    #         put :upload_resume,
    #             consultant: { resume: fixture_file_upload('a_pdf.pdf', 'application/pdf') }
    #       end
    #
    #       it { should render_template(:resume) }
    #     end
    #   end
    # end
  end
end
