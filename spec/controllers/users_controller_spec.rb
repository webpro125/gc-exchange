require 'spec_helper'

describe UsersController do
  let!(:company) { FactoryGirl.create(:company, :with_owner) }
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:user, company_id: company.id)
  end

  describe 'logged in ' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'strong_params' do
        it do
          should permit(:first_name, :last_name, :email).for(:create,
                                                             params: { company_id: company.id })
        end

        it do
          should permit(:first_name, :last_name, :email).for(:update,
                                                             params: { company_id: company.id,
                                                                       id: user.id })
        end
      end

      describe 'GET index' do
        let!(:users) { FactoryGirl.create_list(:user, 5, company: company) }
        let!(:not_shown_users) { FactoryGirl.create_list(:user, 2, :with_company) }

        before do
          get :index, company_id: company.to_param
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:index) }
        it { should respond_with(200) }

        it 'assigns associated users as @users' do
          expect(assigns(:users)).to match_array(company.users)
        end

        it 'does not assign all users as @users' do
          expect(assigns(:users)).not_to match_array(not_shown_users)
        end
      end

      describe 'GET show' do
        before do
          get :show, company_id: company.to_param, id: record.to_param
        end

        let!(:record) { User.create! valid_attributes }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns the requested user as @user' do
          assigns(:user).should eq(record)
        end
      end

      describe 'GET new' do
        before do
          get :new, company_id: company.to_param
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:new) }
        it { should respond_with(200) }

        it 'assigns a new user as user' do
          assigns(:user).should be_a_new(User)
        end
      end

      describe 'GET edit' do
        before do
          get :edit, company_id: company.to_param, id: record.to_param
        end

        let(:record) { User.create! valid_attributes }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }

        it 'assigns the requested user as @user' do
          assigns(:user).should eq(record)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new User' do
            expect do
              post :create, user: valid_attributes, company_id: company.to_param
            end.to change(User, :count).by(1)
          end

          describe do
            before do
              post :create, user: valid_attributes, company_id: company.to_param
            end

            it 'assigns a newly created user as @user' do
              assigns(:user).should be_a(User)
              assigns(:user).should be_persisted
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(company_user_path(company, User.last)) }
          end
        end

        describe 'with invalid params' do
          before do
            # Trigger the behavior that occurs when invalid params are submitted
            User.any_instance.stub(:save).and_return(false)
            post :create, user: { first_name: '' }, company_id: company.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:new) }

          it 'assigns a newly created but unsaved user as @user' do
            assigns(:user).should be_a_new(User)
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let!(:record) { User.create! valid_attributes }

          it 'updates the requested user' do
            User.any_instance.should_receive(:update).with('first_name' => 'Joe')
            put :update, company_id: company.to_param, id: record.to_param,
                user: { first_name: 'Joe' }
          end

          describe do
            before do
              put :update, company_id: company.to_param, id: record.to_param,
                  user: { first_name: 'Joe' }
            end

            it 'assigns the requested user as @user' do
              put :update, company_id: company.to_param, id: record.to_param,
                  user: valid_attributes
              assigns(:user).should eq(record)
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(company_user_path(company, record)) }
          end
        end

        describe 'with invalid params' do
          before do
            User.any_instance.stub(:save).and_return(false)
            put :update, company_id: company.to_param, id: record.id, user: { first_name: '' }
          end

          let!(:record) { User.create! valid_attributes }

          it 'assigns the user as @user' do
            assigns(:user).should eq(record)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:edit) }
        end
      end

      describe 'DELETE destroy' do
        let!(:record) { User.create! valid_attributes }

        it 'destroys the requested user' do
          expect do
            delete :destroy, company_id: company.to_param, id: record.to_param
          end.to change(User, :count).by(-1)
        end

        describe do
          before do
            delete :destroy, company_id: company.to_param, id: record.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(company_users_url(company)) }
        end
      end
    end

    describe 'as an owner' do
      let(:user) { company.owner }

      describe 'GET index' do
        describe 'owned company' do
          before do
            get :index, company_id: company.to_param
          end

          let!(:users) { FactoryGirl.create_list(:user, 5, company: company) }

          it { should_not redirect_to(new_user_session_path) }
        end

        describe 'another company' do
          let!(:users) { FactoryGirl.create_list(:user, 5, company: another_company) }
          let!(:another_company) { FactoryGirl.create(:company, :with_owner) }

          it 'should throw not authorized' do
            expect do
              get :index, company_id: another_company.to_param
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'GET show' do
        describe 'own company user' do
          let(:another_user) { FactoryGirl.create(:user, company: company) }
          before do
            get :show, company_id: company.to_param, id: another_user.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:show) }
          it { should respond_with(200) }

          it 'assigns the requested user as @user' do
            assigns(:user).should eq(another_user)
          end
        end

        describe 'another company user' do
          let(:another_company) { FactoryGirl.create(:company, :with_owner) }

          it 'raises error' do
            expect do
              get :show, company_id: another_company.to_param, id: another_company.owner.to_param
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'GET new' do
        before do
          get :new, company_id: company.to_param
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:new) }
        it { should respond_with(200) }

        it 'assigns a new user as user' do
          assigns(:user).should be_a_new(User)
        end
      end

      describe 'GET edit' do
        describe 'own company user' do
          let(:another_user) { FactoryGirl.create(:user, company: company) }
          before do
            get :edit, company_id: company.to_param, id: another_user.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:edit) }
          it { should respond_with(200) }

          it 'assigns the requested user as @user' do
            assigns(:user).should eq(another_user)
          end
        end

        describe 'another company user' do
          let(:another_company) { FactoryGirl.create(:company, :with_owner) }

          it 'raises error' do
            expect do
              get :edit, company_id: another_company.to_param, id: another_company.owner.to_param
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'POST create' do
        let(:other_company) { FactoryGirl.create(:company, :with_owner) }

        describe 'with valid params' do
          it 'creates a new User' do
            expect do
              post :create, user: valid_attributes, company_id: company.to_param
            end.to change(User, :count).by(1)
          end

          describe do
            before do
              post :create, user: valid_attributes, company_id: company.to_param
            end

            it 'assigns a newly created user as @user' do
              assigns(:user).should be_a(User)
              assigns(:user).should be_persisted
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(company_user_path(company, User.last)) }
          end
        end

        describe 'with invalid params' do
          before do
            # Trigger the behavior that occurs when invalid params are submitted
            User.any_instance.stub(:save).and_return(false)
            post :create, user: { first_name: '' }, company_id: company.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:new) }

          it 'assigns a newly created but unsaved user as @user' do
            assigns(:user).should be_a_new(User)
          end
        end

        it 'raises error' do
          expect do
            post :create, user: valid_attributes, company_id: other_company.to_param
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end

      describe 'PUT update' do
        let(:record) { FactoryGirl.create(:user, company: company) }

        describe 'users company' do
          before do
            put :update, company_id: company.to_param, id: record.to_param,
                user: { first_name: 'Joe' }
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(company_user_path(company, record)) }

          it 'assigns the requested user as @user' do
            assigns(:user).should eq(record)
          end
        end

        describe 'another companies user' do
          let(:another_user) { FactoryGirl.create(:user, :with_company) }

          it 'raises error' do
            expect do
              put :update, id: another_user.to_param, company_id: company.to_param,
                  user: { first_name: 'Joe' }
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'DELETE destroy' do
        it 'raises error' do
          expect do
            delete :destroy, company_id: company.to_param, id: user.to_param
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end
    end
  end

  describe 'not logged in' do
    describe 'GET index' do
      before do
        get :index, company_id: company.to_param
      end

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET show' do
      before do
        get :show, company_id: company.to_param, id: record.id
      end

      let!(:record) { User.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET new' do
      before do
        get :new, company_id: company.to_param
      end

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET edit' do
      before do
        get :edit, company_id: company.to_param, id: record.id
      end

      let(:record) { User.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'POST create' do
      describe do
        before do
          post :create, company_id: company.to_param, user: valid_attributes
        end

        it { should redirect_to(new_user_session_path) }
      end
    end

    describe 'PUT update' do
      before do
        put :update, company_id: company.to_param, id: record.id, user: valid_attributes
      end

      let!(:record) { User.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, company_id: company.to_param, id: record.id
      end

      let!(:record) { User.create! valid_attributes }
      it { should redirect_to(new_user_session_path) }
    end
  end
end
