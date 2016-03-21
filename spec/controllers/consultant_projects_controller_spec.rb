require 'spec_helper'
require 'byebug'

describe ConsultantProjectsController do
  describe 'logged in' do
    before do
      sign_in user
    end

    let(:valid_attributes) do
      FactoryGirl.attributes_for(:project, travel_authorization_id: TravelAuthorization.first.id, consultant_id: user.consultant.id)
    end

    describe 'as a consultant' do
      let(:user) { FactoryGirl.create(:user, :wicked_finish) }

      describe 'GET index' do
        before do
          get :index, {}
        end

        let!(:projects) { FactoryGirl.create_list(:project, 2, consultant: user.consultant) }
        let!(:hidden_projects) { FactoryGirl.create_list(:project, 2) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:index) }
        it { should respond_with(200) }

        it 'assigns all projects as @projects' do
          assigns(:projects).should match_array(projects)
        end
      end

      describe 'GET show' do
        before do
          get :show, id: project.to_param
        end

        let!(:project) { FactoryGirl.create(:project, consultant: user.consultant) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns the requested project as @project' do
          assigns(:project).should eq(project)
        end
      end

      describe 'PUT agree_to_terms' do
        let!(:project) { FactoryGirl.create(:project, consultant: user.consultant) }

        it 'updates the requested project' do
          ProjectSetStatus.any_instance.should_receive(:agree_to_terms_and_save) { true }
          put :agree_to_terms, id: project.to_param
        end

        describe do
          before do
            put :agree_to_terms, id: project.to_param
          end

          it 'assigns the requested project as @project' do
            put :agree_to_terms, id: project.to_param
            assigns(:project).should eq(project)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(consultant_projects_path) }
        end
      end

      describe 'PUT reject_terms' do
        let!(:project) { FactoryGirl.create(:project, consultant: user.consultant) }

        it 'updates the requested project' do
          ProjectSetStatus.any_instance.should_receive(:under_revision_and_save) { true }
          put :reject_terms, id: project.to_param
        end

        describe do
          before do
            put :reject_terms, id: project.to_param
          end

          it 'assigns the requested project as @project' do
            put :reject_terms, id: project.to_param
            assigns(:project).should eq(project)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(consultant_projects_path) }
        end
      end

      describe 'PUT not_interested' do
        let!(:project) { FactoryGirl.create(:project, consultant: user.consultant) }

        it 'updates the requested project' do
          ProjectSetStatus.any_instance.should_receive(:not_interested_and_save) { true }
          put :not_interested, id: project.to_param
        end

        describe do
          before do
            put :not_interested, id: project.to_param
          end

          it 'assigns the requested project as @project' do
            put :not_interested, id: project.to_param
            assigns(:project).should eq(project)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(consultant_projects_path) }
        end
      end
    end
  end
end
