require 'spec_helper'

describe ProjectHistoriesController do
  let!(:project_type) { FactoryGirl.create(:project_type) }
  let(:consultant) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }
  let(:position) { FactoryGirl.create(:position) }
  let(:phone) { FactoryGirl.attributes_for(:phone, phone_type_id: PhoneType.first.id) }
  let(:project_history_positions) do
    FactoryGirl.attributes_for(:project_history_position, position_id: position.id)
  end

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:project_history,
                               consultant:       consultant,
                               project_type_id:  project_type.id,
                               position_ids:     [position.id],
                               phone_attributes: phone)
  end

  describe 'when logged in' do
    before do
      sign_in consultant
    end

    describe "GET 'index'" do
      let!(:projects) { FactoryGirl.create_list(:project_history, 4, consultant: consultant) }

      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'assigns projects' do
        get :index
        expect(assigns(:projects)).to match_array(projects)
      end

      it 'does not include other consultants project_history' do
        unfound_projects = FactoryGirl.create_list(:project_history, 2)
        get :index
        expect(assigns(:projects)).not_to match_array(unfound_projects)
      end
    end

    describe "GET 'new'" do
      it 'renders #new' do
        get :new
        expect(response).to render_template :new
      end

      it 'assigns form' do
        get :new
        expect(assigns(:form)).to be_a(ProjectHistoryForm)
      end
    end

    describe "POST 'create'" do
      describe 'with valid paramaters' do
        it 'redirects to project_histories_path' do
          post :create, project_history: valid_attributes
          expect(response).to redirect_to project_histories_path
        end

        it 'persists the record' do
          expect do
            post :create, project_history: valid_attributes
          end.to change { ProjectHistory.count }.by(1)
        end

        it 'sends a flash message' do
          post :create, project_history: valid_attributes
          expect(flash[:success]).to eq(I18n.t('controllers.project_history.create.success'))
        end
      end

      describe 'with invalid paramaters' do
        before do
          allow_any_instance_of(ProjectHistoryForm).to receive(:validate) { false }
        end

        it 'renders "new"' do
          post :create, project_history: valid_attributes
          expect(response).to render_template :new
        end

        it 'does not persist the record' do
          expect do
            post :create, project_history: valid_attributes
          end.not_to change { ProjectHistory.count }
        end
      end
    end

    describe "GET 'edit'" do
      describe 'with consultants project_history' do
        let!(:project_history) { FactoryGirl.create(:project_history, consultant: consultant) }

        it 'renders #edit' do
          get :edit, id: project_history.id
          expect(response).to render_template :edit
        end

        it 'assigns project' do
          get :edit, id: project_history.id
          expect(assigns(:project)).to eq(project_history)
        end
      end

      describe 'with different users project_history' do
        let!(:project_history) { FactoryGirl.create(:project_history) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { get :edit, id: project_history.id }.to raise_exception Pundit::NotAuthorizedError
        end
      end
    end

    describe "PUT 'update'" do
      describe 'with valid parameters' do
        let(:project_history) { consultant.project_histories.create!(valid_attributes) }

        it 'redirects to project_histories_path' do
          put :update, project_history: project_history.attributes, id: project_history.id
          expect(response).to redirect_to project_histories_path
        end

        it 'persists the record' do
          ProjectHistoryForm.any_instance.should_receive(:save)
          put :update, project_history: project_history.attributes, id: project_history.id
        end

        it 'sends a flash message' do
          put :update, project_history: project_history.attributes, id: project_history.id
          expect(flash[:success]).to eq(I18n.t('controllers.project_history.update.success'))
        end
      end

      describe 'with invalid parameters' do
        let(:project_history) { consultant.project_histories.create!(valid_attributes) }

        it 'renders "edit"' do
          put :update, project_history: { client_company: nil }, id: project_history.id
          expect(response).to render_template :edit
        end

        it 'does not persist the record' do
          ProjectHistoryForm.any_instance.should_receive(:validate).and_return(false)
          put :update, project_history: { client_company: nil }, id: project_history.id
        end
      end

      describe 'with different users project_history' do
        let!(:project_history) { FactoryGirl.create(:project_history) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect do
            put :update, project_history: valid_attributes, id: project_history.id
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end
    end

    describe "DELETE 'destroy'" do
      let!(:project) { consultant.project_histories.create!(valid_attributes) }

      describe 'with valid params' do
        it 'deletes the project_history' do
          expect do
            delete :destroy, id: project.id
          end.to change { ProjectHistory.count }.from(1).to(0)
        end
      end

      describe 'with different users project_history' do
        let(:other_project) { FactoryGirl.create(:project_history) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { delete :destroy, id: other_project.id }.to raise_exception
          ActiveRecord::RecordNotFound
        end
      end
    end
  end

  describe 'when not logged in' do
    before do
      sign_out consultant
    end

    it 'should redirect to login for "GET" requests' do
      [:new].each do |method|
        get method
        expect(response).to redirect_to(new_consultant_session_path)
      end

      project_history = FactoryGirl.create(:project_history)
      [:edit].each do |method|
        get method, id: project_history.id
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "POST" requests' do
      [:create].each do |method|
        post method, project_history: valid_attributes
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "PUT" requests' do
      project_history = FactoryGirl.create(:project_history)

      [:update].each do |method|
        put method, id: project_history.id
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "DELETE" requests' do
      project_history = FactoryGirl.create(:project_history)

      [:destroy].each do |method|
        delete method, id: project_history.id
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end
  end
end
