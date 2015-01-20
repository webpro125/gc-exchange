require 'spec_helper'

describe CreateProfileController do
  before do
    sign_in user
  end

  let!(:user) { FactoryGirl.create(:confirmed_consultant) }

  describe 'basic_information' do
    let(:m) { :basic_information }
    let(:valid_attributes) do
      { id: m, consultant: { first_name: 'first_name' } }
    end

    describe 'GET basic_information' do
      before do
        get :show, id: m
      end

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of BasicInformationForm
      end

      it { should respond_with(200) }
      it { should render_template(m) }
    end

    describe 'PUT basic_information' do
      it 'should change wizard step' do
        expect_any_instance_of(Consultant).to receive(:wizard_step=)
        put :update, valid_attributes
      end

      it 'assigns @form' do
        expect_any_instance_of(BasicInformationForm).to receive(:validate) { true }
        put :update, valid_attributes
      end
    end
  end

  describe 'qualifications' do
    let(:m) { :qualifications }
    let(:valid_attributes) do
      { id: m, consultant: { first_name: 'first_name' } }
    end

    describe 'GET qualifications' do
      before do
        user.educations << FactoryGirl.create(:education)
        get :show, id: :qualifications
      end

      it 'should create only one education fill instance' do
        expect(user.educations).not_to receive(:build)
      end

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of QualificationsForm
      end

      it { should respond_with(200) }
      it { should render_template(m) }
    end

    describe 'PUT qualifications' do
      it 'should change wizard step' do
        expect_any_instance_of(Consultant).to receive(:wizard_step=)
        put :update, valid_attributes
      end

      it 'assigns @form' do
        expect_any_instance_of(QualificationsForm).to receive(:validate) { true }
        put :update, valid_attributes
      end
    end
  end

  describe 'other_information' do
    let(:m) { :other_information }
    let(:valid_attributes) do
      { id: m, consultant: { first_name: 'first_name' } }
    end

    describe 'GET other_information' do
      before do
        user.phones << FactoryGirl.build(:phone)
        get :show, id: m
      end

      it 'should create only one phone fill instance' do
        expect(user.phones).not_to receive(:build)
      end

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of OtherInformationForm
      end

      it { should respond_with(200) }
      it { should render_template(m) }
    end

    describe 'PUT other_information' do
      it 'should change wizard step' do
        expect_any_instance_of(Consultant).to receive(:wizard_step=)
        put :update, valid_attributes
      end

      it 'assigns @form' do
        expect_any_instance_of(OtherInformationForm).to receive(:validate) { true }
        put :update, valid_attributes
      end
    end
  end

  describe 'background_information' do
    let!(:m) { :background_information }
    let(:valid_attributes) do
      { id: :background_information,
        consultant: {
          background_attributes: FactoryGirl.attributes_for(:background,
                                                            consultant: user,
                                                            id: user.id.to_s,
                                                            citizen: 'true',
                                                            convicted: 'false',
                                                            parole: 'false',
                                                            illegal_drug_use: 'false',
                                                            illegal_purchase: 'false',
                                                            illegal_prescription: 'false',
                                                            information_is_correct: '1')
        }
      }
    end

    describe 'GET background_information' do
      before do
        get :show, id: m
      end

      it { should respond_with(200) }
      it { should render_template(m) }
    end

    describe 'PUT background_information' do
      it 'should change wizard step' do
        expect_any_instance_of(Consultant).to receive(:wizard_step=)
        put :update, valid_attributes
      end

      it 'should call on_hold on save' do

        expect_any_instance_of(ConsultantSetStatus).to(
          receive(:on_hold_and_save) { true })

        put :update, valid_attributes
      end
    end
  end

  describe 'project_history' do
    let!(:m) { :project_history }
    let(:valid_attributes) do
      { id: :project_history,
        project_history: FactoryGirl.attributes_for(:project_history,
                                                    position_ids:    Position.pluck(:id).sample(2),
                                                    project_type_id: ProjectType.first.id)
      }
    end

    describe 'GET project_history' do
      before do
        get :show, id: m
      end

      it 'assigns @form' do
        expect(assigns(:form)).to be_a_kind_of ProjectHistoryForm
      end

      it 'assigns @form' do
        expect_any_instance_of(ProjectHistoryForm).to receive(:validate) { true }
        put :update, valid_attributes
      end
      it { should respond_with(200) }
      it { should render_template(m) }
    end

    describe 'PUT project_history' do
      it 'should change wizard step' do
        expect_any_instance_of(Consultant).to receive(:wizard_step=)
        put :update, valid_attributes
      end

      it 'assigns @form' do
        expect_any_instance_of(ProjectHistoryForm).to receive(:validate) { true }
        put :update, valid_attributes
      end
    end

    describe 'contract' do
      let(:m) { :contract }
      let(:valid_attributes) do
        { id: m, consultant: { first_name: 'first_name' } }
      end

      describe 'GET contract' do
        before do
          get :show, id: m
        end

        it 'assigns @form' do
          expect(assigns(:form)).to be_a_kind_of EditConsultantForm
        end

        it { should respond_with(200) }
        it { should render_template(m) }
      end

      describe 'PUT contract' do
        it 'should change wizard step' do
          expect_any_instance_of(Consultant).to receive(:wizard_step=)
          put :update, valid_attributes
        end

        it 'assigns @form' do
          expect_any_instance_of(EditConsultantForm).to receive(:validate) { true }
          put :update, valid_attributes
        end
      end
    end
  end

  describe 'logged in completed wizard' do
    before do
      get :show, id: :other_information
    end

    let(:user) { FactoryGirl.create(:confirmed_consultant, :wicked_finish) }

    it 'should redirect to root' do
      expect(response).to redirect_to profile_completed_path
    end
  end
end
