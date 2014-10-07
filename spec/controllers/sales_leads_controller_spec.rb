require 'spec_helper'

describe SalesLeadsController do
  let(:sales_lead) { FactoryGirl.attributes_for(:sales_lead) }

  describe 'GET "new"' do
    it 'renders #new' do
      get :new
      expect(response).to render_template :new
    end
  end

  it 'assigns sales_lead' do
    get :new
    expect(assigns(:sales_lead)).to be_a_new(SalesLead)
  end

  describe 'POST "create"' do
    describe 'with valid paramaters' do
      it 'redirects to root_path' do
        post :create, sales_lead: sales_lead
        expect(response).to redirect_to root_path
      end

      it 'persists the record' do
        SalesLead.any_instance.should_receive(:save).and_return(true)
        post :create, sales_lead: sales_lead
      end

      it 'sends a flash message' do
        post :create, sales_lead: sales_lead
        expect(flash[:success]).to eq('Message was successfully sent')
      end
    end

    describe 'with invalid paramaters' do
      before do
        sales_lead[:email] = nil
      end

      it 'does not persist the record' do
        SalesLead.any_instance.should_receive(:save).and_return(false)
        post :create, sales_lead: sales_lead
      end
    end
  end
end
