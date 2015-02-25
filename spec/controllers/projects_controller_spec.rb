require 'spec_helper'

describe ProjectsController do
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:project, travel_authorization_id: TravelAuthorization.first.id)
  end

  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      describe 'strong_params' do
        it do
          consultant = FactoryGirl.create(:consultant)
          should permit(:travel_authorization_id, :proposed_start, :proposed_end, :proposed_rate,
                        :project_name, :project_location).for(:create,
                                                              params: { consultant_id:
                                                                          consultant.id })
        end

        it do
          project = FactoryGirl.create(:project, user: user)
          should permit(:travel_authorization_id, :proposed_start, :proposed_end, :proposed_rate,
                        :project_name, :project_location).for(:update, params: { id: project.id })
        end
      end

      describe 'GET index' do
        before do
          get :index, {}
        end

        let!(:projects) { FactoryGirl.create_list(:project, 2, user: user) }
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

        let!(:project) { FactoryGirl.create(:project, user: user) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns the requested project as @project' do
          assigns(:project).should eq(project)
        end
      end

      describe 'GET new' do
        before do
          get :new, consultant_id: consultant.id
        end

        let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:new) }
        it { should respond_with(200) }

        it 'assigns a new project as @project' do
          assigns(:project).should be_a_new(Project)
        end

        it 'assigns a new form as @form' do
          assigns(:form).should be_a_kind_of(ProjectForm)
        end
      end

      describe 'GET edit' do
        before do
          get :edit, id: project.to_param
        end

        let!(:project) { FactoryGirl.create(:project, user: user) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }

        it 'assigns the requested project as @project' do
          assigns(:project).should eq(project)
        end

        it 'assigns a new form as @form' do
          assigns(:form).should be_a_kind_of(ProjectForm)
        end
      end

      describe 'POST create' do
        let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

        describe 'with valid params' do
          it 'creates a new Project' do
            expect do
              post :create, project: valid_attributes, consultant_id: consultant.id
            end.to change(Project, :count).by(1)
          end

          describe do
            before do
              post :create, project: valid_attributes, consultant_id: consultant.id
            end

            it 'assigns a newly created project as @project' do
              assigns(:project).should be_a(Project)
              assigns(:project).should be_persisted
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(Project.last) }
          end
        end

        describe 'with invalid params' do
          before do
            # Trigger the behavior that occurs when invalid params are submitted
            Project.any_instance.stub(:save).and_return(false)
            post :create, project: { project_name: '' }, consultant_id: consultant.id
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:new) }

          it 'assigns a newly created but unsaved project as @project' do
            assigns(:project).should be_a_new(Project)
          end

          it 'assigns a new form as @form' do
            assigns(:form).should be_a_kind_of(ProjectForm)
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let!(:project) do
            FactoryGirl.create(:project, user: user, contact_status: :under_revision)
          end

          it 'updates the requested project' do
            ProjectForm.any_instance.should_receive(:validate).with('project_name' => 'New Name')
            put :update, id: project.to_param, project: { project_name: 'New Name' }
          end

          describe do
            before do
              put :update, id: project.to_param, project: { project_name: 'New Name' }
            end

            it 'assigns the requested project as @project' do
              put :update, id: project.to_param, project: valid_attributes
              assigns(:project).should eq(project)
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(project_path(project)) }
          end
        end

        describe 'with invalid params' do
          before do
            Project.any_instance.stub(:save).and_return(false)
            put :update, id: project.to_param, project: { project_name: '' }
          end

          let!(:project) { FactoryGirl.create(:project, user: user) }

          it 'assigns the project as @project' do
            assigns(:project).should eq(project)
          end

          it 'assigns a new form as @form' do
            assigns(:form).should be_a_kind_of(ProjectForm)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:edit) }
        end
      end

      describe 'PUT not_pursuing' do
        let!(:project) { FactoryGirl.create(:project, user: user) }

        it 'updates the requested project' do
          ProjectSetStatus.any_instance.should_receive(:not_pursuing_and_save) { true }
          put :not_pursuing, id: project.to_param
        end

        describe do
          before do
            put :not_pursuing, id: project.to_param
          end

          it 'assigns the requested project as @project' do
            put :not_pursuing, id: project.to_param
            assigns(:project).should eq(project)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(projects_path) }
        end
      end
    end

    describe 'as a consultant' do
      let(:user) { FactoryGirl.create(:confirmed_consultant) }

      describe 'GET index' do
        before do
          get :index, {}
        end

        let!(:projects) { FactoryGirl.create_list(:project, 2, consultant: user) }
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

        let!(:project) { FactoryGirl.create(:project, consultant: user) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns the requested project as @project' do
          assigns(:project).should eq(project)
        end
      end

      describe 'GET new' do
        it 'is not authorized' do
          expect do
            get :new, consultant_id: user.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'GET edit' do
        let(:project) { FactoryGirl.create(:project, consultant: user) }

        it 'is not authorized' do
          expect do
            get :edit, id: project.id
          end.to raise_error Pundit::NotAuthorizedError
        end
      end

      describe 'PUT agree_to_terms' do
        let!(:project) { FactoryGirl.create(:project, consultant: user) }

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
          it { should redirect_to(projects_path) }
        end
      end

      describe 'PUT reject_terms' do
        let!(:project) { FactoryGirl.create(:project, consultant: user) }

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
          it { should redirect_to(projects_path) }
        end
      end

      describe 'PUT not_interested' do
        let!(:project) { FactoryGirl.create(:project, consultant: user) }

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
          it { should redirect_to(projects_path) }
        end
      end
    end
  end
end
