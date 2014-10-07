require 'spec_helper'

describe MilitariesController do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:military, consultant: consultant)
  end

  describe 'when logged in' do
    before do
      sign_in consultant
      @military = FactoryGirl.create(:military)
    end

    describe 'POST "create"' do
      describe 'with valid paramaters' do
        it 'redirects to consultant_root_path' do
          post :create, military: valid_attributes
          expect(response).to redirect_to consultant_root_path
        end

        it 'persists the record' do
          Military.any_instance.should_receive(:save).and_return(true)
          post :create, military: valid_attributes
        end

        it 'sends a flash message' do
          post :create, military: valid_attributes
          expect(flash[:success]).to eq(I18n.t('controllers.military.create.success'))
        end
      end
    end

    describe 'PUT "update"' do
      before do
        @military = FactoryGirl.attributes_for(:military)
        Military.create(@military.merge(consultant_id: consultant.id))
      end

      describe 'with valid parameters' do
        it 'redirects to consultant_root_path' do
          put :update, military: @military
          expect(response).to redirect_to consultant_root_path
        end

        it 'persists the record' do
          Military.any_instance.should_receive(:update).and_return(true)
          put :update, military: @military
        end

        it 'sends a flash message' do
          put :update, military: @military
          expect(flash[:success]).to eq(I18n.t('controllers.military.update.success'))
        end
      end

      #   describe 'with invalid parameters' do
      #     before do
      #       @military = FactoryGirl.attributes_for(:military)
      #       Military.create(@military.merge(consultant_id: consultant.id))
      #     end
      #
      #   it 'renders "update"' do
      #     put :update, military: { service_end_date: 6.months.ago }
      #     expect(response).to render_template :update
      #   end
      # end
    end
  end

  describe 'when not logged in' do
    before do
      sign_out consultant
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
