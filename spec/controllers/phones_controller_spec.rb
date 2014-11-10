require 'spec_helper'

describe PhonesController do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

  describe 'when logged in' do
    before do
      sign_in consultant
      @phone = FactoryGirl.attributes_for(:phone).merge(
          phone_type_id: FactoryGirl.create(:phone_type).id)
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
          expect(response).to redirect_to edit_profile_path
        end

        it 'persists the record' do
          PhoneUnsetPrimaries.any_instance.should_receive(:save).and_return(true)
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
          PhoneUnsetPrimaries.any_instance.should_receive(:save).and_return(false)
          post :create, phone: @phone
        end
      end
    end

    describe 'DELETE "destroy"' do
      before do
        @phone = consultant.phones.create(@phone)
      end

      describe 'with different users phone' do
        let(:phone) { FactoryGirl.create(:phone) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect do
            delete :destroy, id: phone.id
          end.to raise_exception ActiveRecord::RecordNotFound
        end
      end

      describe 'with valid params' do
        it 'deletes the phone' do
          expect { delete :destroy, id: @phone.id }.to change { Phone.count }.from(1).to(0)
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
    end

    it 'should redirect to login for "POST" requests' do
      phone = FactoryGirl.attributes_for(:phone)

      [:create].each do |method|
        post method, phone: phone
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "DELETE" requests' do
      phone = FactoryGirl.create(:phone)

      [:destroy].each do |method|
        delete method, id: phone.id
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end
  end
end
