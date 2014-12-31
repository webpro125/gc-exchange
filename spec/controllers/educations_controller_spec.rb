require 'spec_helper'

describe EducationsController do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }

  describe 'when logged in' do
    before do
      sign_in consultant
      @education = FactoryGirl.attributes_for(:education).merge(
        degree_id: FactoryGirl.create(:degree).id)
    end

    describe "GET 'new'" do
      it 'renders #new' do
        get :new
        expect(response).to render_template :new
      end

      it 'assigns education' do
        get :new
        expect(assigns(:education)).to be_a_new(Education)
      end
    end

    describe "POST 'create'" do
      describe 'with valid paramaters' do
        it 'redirects to educations_path' do
          post :create, education: @education
          expect(response).to redirect_to edit_profile_path
        end

        it 'persists the record' do
          Education.any_instance.should_receive(:save).and_return(true)
          post :create, education: @education
        end

        it 'sends a flash message' do
          post :create, education: @education
          expect(flash[:success]).to eq(I18n.t('controllers.education.create.success'))
        end
      end

      describe 'with invalid paramaters' do
        before do
          @education[:school] = nil
        end

        it 'renders "new"' do
          post :create, education: @education
          expect(response).to render_template :new
        end

        it 'does not persist the record' do
          Education.any_instance.should_receive(:save).and_return(false)
          post :create, education: @education
        end
      end
    end

    describe 'DELETE "destroy"' do
      before do
        @education = consultant.educations.create(@education)
      end

      describe 'with different users education' do
        let(:education) { FactoryGirl.create(:education) }

        it 'raises ActiveRecord::RecordNotFound' do
          expect do
            delete :destroy, id: education.id
          end.to raise_exception ActiveRecord::RecordNotFound
        end
      end

      describe 'with valid params' do
        it 'deletes the education' do
          expect { delete :destroy, id: @education.id }.to change { Education.count }.from(1).to(0)
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
      education = FactoryGirl.attributes_for(:education)

      [:create].each do |method|
        post method, education: education
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end

    it 'should redirect to login for "DELETE" requests' do
      education = FactoryGirl.create(:education)

      [:destroy].each do |method|
        delete method, id: education.id
        expect(response).to redirect_to(new_consultant_session_path)
      end
    end
  end
end
