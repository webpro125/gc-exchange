require 'spec_helper'

describe ConsultantsController do

  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'GET index' do
        let!(:in_progress) { FactoryGirl.create_list(:consultant, 2, :in_progress) }
        let!(:approved) { FactoryGirl.create_list(:consultant, 2, :approved) }
        let!(:pending_approval) { FactoryGirl.create_list(:consultant, 2, :pending_approval) }
        let!(:rejected) { FactoryGirl.create_list(:consultant, 2, :rejected) }

        before do
          get :index
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:index) }
        it { should respond_with(200) }

        it 'assigns all pending_approval consultants' do
          assigns(:consultants).should match_array(pending_approval)
        end
      end

      describe 'GET show' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved) }

        before do
          get :show, id: consultant.id
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns consultant' do
          assigns(:consultant).should eq(consultant)
        end
      end

      describe 'download' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }
        before do
          get :download, id: consultant.id
        end

        it { should_not redirect_to(new_user_session_path) }

        it 'resume' do
        end
      end

      describe 'PUT approve' do
        describe 'pending_approval status' do
          let!(:consultant) { FactoryGirl.create(:consultant, :pending_approval) }

          it 'allows approve' do
            expect do
              put :approve, id: consultant.id
            end.to change { consultant.reload.approved? }.to true
          end

          describe 'succcess' do
            before do
              put :approve, id: consultant.id
            end

            it { should redirect_to(consultants_path) }
          end

          describe 'failure' do
            before do
              allow_any_instance_of(ConsultantSetStatus).to receive(:approve_and_save) { false }
              put :approve, id: consultant.id
            end

            it { should redirect_to(consultant_path(consultant)) }
          end
        end

        describe 'rejected status' do
          let(:consultant) { FactoryGirl.create(:consultant, :rejected) }

          it 'allows approve' do
            expect do
              put :approve, id: consultant.id
            end.to change { consultant.reload.approved? }.to true
          end

          describe 'success' do
            before do
              put :approve, id: consultant.id
            end

            it { should redirect_to(consultants_path) }
          end
        end

        describe 'in_progress' do
          let(:consultant) { FactoryGirl.create(:consultant, :in_progress) }

          it 'does not allow approve' do
            expect do
              put :approve, id: consultant.id
            end.to raise_error Pundit::NotAuthorizedError
          end
        end

        describe 'approved' do
          let(:consultant) { FactoryGirl.create(:consultant, :approved) }

          it 'does not allow approve' do
            expect do
              put :approve, id: consultant.id
            end.to raise_error Pundit::NotAuthorizedError
          end
        end
      end

      describe 'PUT reject' do
        describe 'pending_approval status' do
          let(:consultant) { FactoryGirl.create(:consultant, :pending_approval) }

          it 'allows approve' do
            expect do
              put :reject, id: consultant.id
            end.to change { consultant.reload.rejected? }.to true
          end

          describe 'success' do
            before do
              put :reject, id: consultant.id
            end

            it { should redirect_to(consultants_path) }
          end

          describe 'failure' do
            before do
              allow_any_instance_of(ConsultantSetStatus).to receive(:reject_and_save) { false }
              put :reject, id: consultant.id
            end

            it { should redirect_to(consultant_path(consultant)) }
          end
        end

        describe 'rejected status' do
          let(:consultant) { FactoryGirl.create(:consultant, :rejected) }

          it 'does not allow approve' do
            expect do
              put :reject, id: consultant.id
            end.to raise_error Pundit::NotAuthorizedError
          end
        end

        describe 'in_progress' do
          let(:consultant) { FactoryGirl.create(:consultant, :in_progress) }

          it 'does not allow approve' do
            expect do
              put :reject, id: consultant.id
            end.to raise_error Pundit::NotAuthorizedError
          end
        end

        describe 'approved' do
          let(:consultant) { FactoryGirl.create(:consultant, :approved) }

          it 'allows approve' do
            expect do
              put :reject, id: consultant.id
            end.to change { consultant.reload.rejected? }.to true
          end

          describe do
            before do
              put :reject, id: consultant.id
            end

            it { should redirect_to(consultants_path) }
          end
        end
      end
    end

    describe 'as Owner' do
      let(:user) { FactoryGirl.create(:user, :as_owner) }

      describe 'GET index' do
        it 'raises error' do
          expect do
            get :index
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'GET show' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved) }

        before do
          get :show, id: consultant.id
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns consultant' do
          assigns(:consultant).should eq(consultant)
        end
      end

      describe 'PUT approve' do
        let(:consultant) { FactoryGirl.create(:consultant) }

        it 'raises error' do
          expect do
            put :approve, id: consultant.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'PUT reject' do
        let(:consultant) { FactoryGirl.create(:consultant) }

        it 'raises error' do
          expect do
            put :reject, id: consultant.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'download' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          get :download, id: consultant.id
        end
        it { should_not redirect_to(new_user_session_path) }

        it 'resume' do

        end
      end
    end

    describe 'as user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      describe 'GET index' do
        it 'raises error' do
          expect do
            get :index
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'GET show' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved) }

        before do
          get :show, id: consultant.id
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns consultant' do
          assigns(:consultant).should eq(consultant)
        end
      end

      describe 'PUT approve' do
        let(:consultant) { FactoryGirl.create(:consultant) }

        it 'raises error' do
          expect do
            put :approve, id: consultant.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'PUT reject' do
        let(:consultant) { FactoryGirl.create(:consultant) }

        it 'raises error' do
          expect do
            put :reject, id: consultant.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end
    end
  end

  describe 'logged out' do
    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'download' do
        let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }

        before do
          sign_out user
          allow_any_instance_of(Consultant).to receive(:resume_url) { 'BOOM' }
          get :download, id: consultant.id
        end

        it { should redirect_to(new_user_session_path) }
      end
    end
  end
end
