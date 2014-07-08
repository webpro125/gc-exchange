require 'spec_helper'

describe PhonesController do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

  describe 'when logged in' do
    before do
      sign_in consultant
      @phone = FactoryGirl.attributes_for(:phone).merge(
                                                phone_type_id: FactoryGirl.create(:phone_type).id)
    end

    describe "GET 'index'" do
      before do
        @phones = FactoryGirl.create_list(:phone, 4, phoneable_type: 'Consultant',
                                phoneable_id: consultant.id)
      end

      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it 'assigns phones' do
        get :index
        expect(assigns(:phones)).to match_array(@phones)
      end

      it 'does not include other consultants phones' do
        phones = FactoryGirl.create_list(:phone, 2)
        get :index
        expect(assigns(:phones)).not_to match_array(phones)
      end
    end

    describe "GET 'new'" do
      it 'renders #new' do
        get :new
        expect(response).to render_template :new
      end

      it 'assigns phone' do
        get :new
        expect(assigns(:phone)).to be_a_new(Phone)
      end
    end

    describe "POST 'create'" do
      describe 'with valid paramaters' do
        it 'redirects to phones_path' do
          post :create, phone: @phone
          expect(response).to redirect_to phones_path
        end

        it 'persists the record' do
          Phone.any_instance.should_receive(:save).and_return(true)
          post :create, phone: @phone
        end

        it 'sends a flash message' do
          post :create, phone: @phone
          expect(flash[:success]).to eq(I18n.t('controllers.phone.create.success'))
        end
      end

      describe 'with invalid paramaters' do
        before do
          @phone[:number] = nil
        end

        it 'renders "new"' do
          post :create, phone: @phone
          expect(response).to render_template :new
        end

        it 'does not persist the record' do
          Phone.any_instance.should_receive(:save).and_return(false)
          post :create, phone: @phone
        end
      end
    end

    describe "GET 'show'" do
      before do
        @phone = consultant.phones.create!(@phone)
      end

      describe 'with consultants phone' do
        it 'renders #show' do
          get :show, id: @phone.id
          expect(response).to render_template :show
        end

        it 'assigns phone' do
          get :show, id: @phone.id
          expect(assigns(:phone)).to eq(@phone)
        end
      end

      describe 'with different users phone' do
        let(:phone) { FactoryGirl.create(:phone) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { get :show, id: phone.id }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end

    describe "GET 'edit'" do
      before do
        @phone = consultant.phones.create!(@phone)
      end

      describe 'with consultants phone' do
        it 'renders #edit' do
          get :edit, id: @phone.id
          expect(response).to render_template :edit
        end

        it 'assigns phone' do
          get :edit, id: @phone.id
          expect(assigns(:phone)).to eq(@phone)
        end
      end

      describe 'with different users phone' do
        let(:phone) { FactoryGirl.create(:phone) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { get :edit, id: phone.id }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end

    describe "PUT 'update'" do
      let(:phone) { consultant.phones.create!(@phone) }

      describe 'with valid parameters' do
        it 'redirects to phones_path' do
          put :update, { phone: @phone, id: phone.id }
          expect(response).to redirect_to phones_path
        end

        it 'persists the record' do
          Phone.any_instance.should_receive(:update).and_return(true)
          put :update, { phone: @phone, id: phone.id }
        end

        it 'sends a flash message' do
          put :update, { phone: @phone, id: phone.id }
          expect(flash[:success]).to eq(I18n.t('controllers.phone.update.success'))
        end
      end

      describe 'with invalid parameters' do
        it 'renders "edit"' do
          put :update, { phone: { number: nil }, id: phone.id }
          expect(response).to render_template :edit
        end

        it 'does not persist the record' do
          Phone.any_instance.should_receive(:update).and_return(false)
          put :update, { phone: { number: nil }, id: phone.id }
        end
      end

      describe 'with different users phone' do
        let(:phone1) { FactoryGirl.create(:phone) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { put :update, { phone: phone1, id: phone1.id } }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end

    describe "DELETE 'destroy'" do
      before do
        @phone = consultant.phones.create(@phone)
      end

      describe 'with different users phone' do
        let(:phone) { FactoryGirl.create(:phone) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect { delete :destroy, { id: phone.id } }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end
  end

  describe 'when not logged in' do
    before do
      sign_out consultant
    end

    it 'should redirect to login for "GET" requests' do
      [:index, :new].each do |method|
        get method
        expect(response).to redirect_to(new_consultant_session_path)
      end

      phone = FactoryGirl.create(:phone)
      [:show, :edit].each do |method|
        get method, { id: phone.id }
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "POST" requests' do
      phone = FactoryGirl.attributes_for(:phone)

      [:create].each do |method|
        post method, { phone: phone }
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "PUT" requests' do
      phone = FactoryGirl.create(:phone)

      [:update].each do |method|
        put method, { id: phone.id }
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "DELETE" requests' do
      phone = FactoryGirl.create(:phone)

      [:destroy].each do |method|
        delete method, { id: phone.id }
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end
  end
end
