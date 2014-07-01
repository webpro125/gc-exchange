require 'spec_helper'

describe AddressesController do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

  describe 'when logged in' do
    before do
      sign_in consultant
      @address = FactoryGirl.attributes_for(:address)
    end

    describe 'GET "new"' do
      before do
        get :new
      end

      it 'renders #new' do
        expect(response).to render_template :new
      end

      it 'assigns address' do
        expect(assigns(:address)).to be_a_new(Address)
      end
    end

    describe 'GET "show"' do
      before do
        @address = FactoryGirl.create(:address, consultant: consultant)
        get :show
      end

      it 'renders #show' do
        expect(response).to render_template :show
      end

      it 'assigns address' do
        expect(assigns(:address)).to eq(@address)
      end
    end

    describe 'POST "create"' do
      describe 'with valid paramaters' do
        it 'redirects to consultant_root_path' do
          post :create, address: @address
          expect(response).to redirect_to consultant_root_path
        end

        it 'persists the record' do
          Address.any_instance.should_receive(:save).and_return(true)
          post :create, address: @address
        end
      end

      describe 'with invalid paramaters' do
        before do
          @address[:zipcode] = nil
        end

        it 'renders "new"' do
          post :create, address: @address
          expect(response).to render_template :new
        end

        it 'does not persist the record' do
          Address.any_instance.should_receive(:save).and_return(false)
          post :create, address: @address
        end
      end
    end

    describe 'GET "edit"' do
      before do
        @address = FactoryGirl.create(:address, consultant: consultant)
        get :edit
      end

      it 'renders #edit' do
        expect(response).to render_template :edit
      end

      it 'assigns address' do
        expect(assigns(:address)).to eq(@address)
      end
    end

    describe 'PUT "update"' do
      before do
        @address = FactoryGirl.attributes_for(:address)
        Address.create(@address.merge(consultant_id: consultant.id))
      end

      describe 'with valid parameters' do
        it 'redirects to consultant_root_path' do
          put :update, address: @address
          expect(response).to redirect_to consultant_root_path
        end

        it 'persists the record' do
          Address.any_instance.should_receive(:update).and_return(true)
          put :update, address: @address
        end
      end

      describe 'with invalid parameters' do
        before do
          @address[:zipcode] = nil
        end

        it 'renders "edit"' do
          put :update, address: @address
          expect(response).to render_template :edit
        end

        it 'does not persist the record' do
          Address.any_instance.should_receive(:update).and_return(false)
          put :update, address: @address
        end
      end
    end
  end

  describe 'when not logged in' do
    before do
      sign_out consultant
    end

    it 'should redirect to login for "GET" requests' do
      [:show, :edit, :new].each do |method|
        get method
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "POST" requests' do
      [:create].each do |method|
        post method
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "PUT" requests' do
      [:update].each do |method|
        patch method
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end
  end
end
