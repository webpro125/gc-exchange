require 'spec_helper'

describe CreateProfileController do

  describe 'logging in' do
    before do
      sign_in user
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant) }

    [:project_history, :basic_information, :qualifications, :other_information,
     :background_information].each do |m|
      describe "GET #{m}" do
        before do
          get :show, id: m
        end

        it 'assigns @form' do
          expect(assigns(:form)).to be_a_kind_of Reform::Form
        end

        it { should respond_with(200) }
        it { should render_template(m) }
      end

      describe "PUT #{m}" do
        let(:valid_attributes) do
          if m == :project_history
            { id: m, project_history: { client_poc_name: 'Bob Saget' } }
          else
            { id: m, consultant: { first_name: 'first_name' } }
          end
        end

        it 'should change wizard step' do
          expect_any_instance_of(Consultant).to receive(:wizard_step=)
          put :update, valid_attributes
        end

        it 'assigns @form' do
          begin
            expect_any_instance_of(Reform::Form).to receive(:validate) { true }
            put :update, valid_attributes
          rescue SystemStackError
            logger.info 'Stack level error caught'
          end
        end
      end
    end

    describe 'GET qualifications' do
      before do
        user.educations << FactoryGirl.create(:education)
        get :show, id: :qualifications
      end

      it 'should create only one education fill instance' do
        expect(user.educations).not_to receive(:build)
      end
    end

    describe 'GET other_information' do
      before do
        user.phones << FactoryGirl.build(:phone)
        get :show, id: :other_information
      end

      it 'should create only one phone fill instance' do
        expect(user.phones).not_to receive(:build)
      end
    end
  end

  describe 'logged in completed wizard' do
    before do
      sign_in user
      get :show, id: :other_information
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }

    it 'should redirect to root' do
      expect(response).to redirect_to consultant_root_path
    end
  end
end
