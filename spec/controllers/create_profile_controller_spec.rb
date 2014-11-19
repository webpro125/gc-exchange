require 'spec_helper'

describe CreateProfileController do

  describe 'logging in' do
    before do
      sign_in user
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant) }

    [:basic_information, :qualifications, :other_information, :background_information,
     :project_history].each do |m|
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

        describe do
          it 'assigns @form' do
            expect_any_instance_of(Reform::Form).to receive(:validate) { true }
            put :update, valid_attributes
          end
        end
      end
    end
  end
end