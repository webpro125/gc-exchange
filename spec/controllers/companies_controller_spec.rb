require 'spec_helper'

describe CompaniesController do
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:company, owner_attributes: FactoryGirl.attributes_for(:user))
  end

  describe 'logged in ' do
    before do
      sign_in user
    end

    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      describe 'strong_params' do
        it do
          should permit(:company_name, owner_attributes: [:first_name, :last_name,
                                                          :email]).for(:create)
        end

        it do
          company = FactoryGirl.create(:company, :with_owner)
          should permit(:company_name, :owner_id).for(:update, params: { id: company.id })
        end
      end

      describe 'GET index' do
        before do
          get :index, {}
        end

        let!(:company) { Company.create! valid_attributes }
        let!(:companies) { FactoryGirl.create_list(:company, 2, :with_owner) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:index) }
        it { should respond_with(200) }

        it 'assigns all companies as @companies' do
          assigns(:companies).should match_array(Company.all)
        end
      end

      describe 'GET show' do
        before do
          get :show, id: company.to_param
        end

        let!(:company) { Company.create! valid_attributes }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns the requested company as @company' do
          assigns(:company).should eq(company)
        end
      end

      describe 'GET new' do
        before do
          get :new
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:new) }
        it { should respond_with(200) }

        it 'assigns a new company as @company' do
          assigns(:company).should be_a_new(Company)
        end
      end

      describe 'GET edit' do
        before do
          get :edit, id: company.to_param
        end

        let(:company) { Company.create! valid_attributes }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:edit) }
        it { should respond_with(200) }

        it 'assigns the requested company as @company' do
          assigns(:company).should eq(company)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Company' do
            expect { post :create, company: valid_attributes }.to change(Company, :count).by(1)
          end

          describe do
            before do
              post :create, company: valid_attributes
            end

            it 'assigns a newly created company as @company' do
              assigns(:company).should be_a(Company)
              assigns(:company).should be_persisted
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(Company.last) }
          end
        end

        describe 'with invalid params' do
          before do
            # Trigger the behavior that occurs when invalid params are submitted
            Company.any_instance.stub(:save).and_return(false)
            post :create, company: { company_name: '' }
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:new) }

          it 'assigns a newly created but unsaved company as @company' do
            assigns(:company).should be_a_new(Company)
          end
        end
      end

      describe 'PUT update' do
        describe 'with valid params' do
          let!(:company) { Company.create! valid_attributes }

          it 'updates the requested company' do
            Company.any_instance.should_receive(:update).with('company_name' => 'New Name')
            put :update, id: company.to_param, company: { company_name: 'New Name' }
          end

          describe do
            before do
              put :update, id: company.to_param, company: { company_name: 'New Name' }
            end

            it 'assigns the requested company as @company' do
              put :update, id: company.to_param, company: valid_attributes
              assigns(:company).should eq(company)
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(company_path(company)) }
          end
        end

        describe 'with invalid params' do
          before do
            Company.any_instance.stub(:save).and_return(false)
            put :update, id: company.to_param, company: { company_name: '' }
          end

          let!(:company) { Company.create! valid_attributes }

          it 'assigns the company as @company' do
            assigns(:company).should eq(company)
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:edit) }
        end
      end

      describe 'DELETE destroy' do
        let!(:company) { Company.create! valid_attributes }

        it 'destroys the requested company' do
          expect { delete :destroy, id: company.to_param }.to change(Company, :count).by(-1)
        end

        describe do
          before do
            delete :destroy, id: company.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(companies_url) }
        end
      end
    end

    describe 'as an owner' do
      let(:user) { company.owner }
      let(:company) { FactoryGirl.create(:company, :with_owner) }

      describe 'GET index' do
        before do
          get :index, {}
        end

        let!(:companies) { FactoryGirl.create_list(:company, 2, :with_owner) }

        it { should_not redirect_to(new_user_session_path) }
        it { should redirect_to(company_path(company)) }
      end

      describe 'GET show' do
        describe 'users company' do
          before do
            get :show, id: company.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:show) }
          it { should respond_with(200) }

          it 'assigns the requested company as @company' do
            assigns(:company).should eq(company)
          end
        end

        describe 'another users company' do
          let(:another_company) { FactoryGirl.create(:company, :with_owner) }

          it 'raises error' do
            expect do
              get :show, id: another_company.to_param
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'GET new' do
        it 'raises error' do
          expect do
            get :new
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end

      describe 'GET edit' do
        describe 'users company' do
          before do
            get :edit, id: company.to_param
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should render_template(:edit) }
          it { should respond_with(200) }

          it 'assigns the requested company as @company' do
            assigns(:company).should eq(company)
          end
        end

        describe 'another users company' do
          it 'raises error' do
            expect do
              get :new
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'POST create' do
        it 'raises error' do
          expect do
            post :create, company: valid_attributes
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end

      describe 'PUT update' do
        describe 'users company' do
          before do
            put :update, id: company.to_param, company: { company_name: 'New Name' }
          end

          it { should_not redirect_to(new_user_session_path) }
          it { should redirect_to(company_path(company)) }

          it 'assigns the requested company as @company' do
            assigns(:company).should eq(company)
          end
        end

        describe 'another users company' do
          let(:another_company) { FactoryGirl.create(:company, :with_owner) }

          it 'raises error' do
            expect do
              put :update, id: another_company.to_param, company: { company_name: 'New Name' }
            end.to raise_exception Pundit::NotAuthorizedError
          end
        end
      end

      describe 'DELETE destroy' do
        it 'raises error' do
          expect do
            delete :destroy, id: company.to_param
          end.to raise_exception Pundit::NotAuthorizedError
        end
      end
    end
  end

  describe 'not logged in' do
    describe 'GET index' do
      before do
        get :index, {}
      end

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET show' do
      before do
        get :show, id: company.to_param
      end

      let!(:company) { Company.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET new' do
      before do
        get :new
      end

      it { should redirect_to(new_user_session_path) }
    end

    describe 'GET edit' do
      before do
        get :edit, id: company.to_param
      end

      let(:company) { Company.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'POST create' do
      describe do
        before do
          post :create, company: valid_attributes
        end

        it { should redirect_to(new_user_session_path) }
      end
    end

    describe 'PUT update' do
      before do
        put :update, id: company.to_param, company: valid_attributes
      end

      let!(:company) { Company.create! valid_attributes }

      it { should redirect_to(new_user_session_path) }
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, id: company.to_param
      end

      let!(:company) { Company.create! valid_attributes }
      it { should redirect_to(new_user_session_path) }
    end
  end
end
