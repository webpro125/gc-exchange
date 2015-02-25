require 'spec_helper'

describe ConversationsController do
  let(:valid_attributes) do
    { subject: 'Test Subject', body: 'Test message.' }
  end

  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as User' do
      let!(:consultant) { FactoryGirl.create(:consultant, :approved) }
      let!(:user) { FactoryGirl.create(:user, :with_company) }
      # let(:conversation) { Mailboxer::Conversation.new(id: 1, subject: 'Test') }

      describe 'conversation strong_params' do
        it do
          consultant = FactoryGirl.create(:consultant)
          should permit(:subject, :message).for(:create,
                                                params: { consultant_id:
                                                            consultant.id })
        end
      end

      # describe 'message strong_params' do
      #   it do
      #     consultant = FactoryGirl.create(:consultant)
      #     should permit(:conversation, :recipients, :reply_body).for(:reply, verb: :post,
      #                                                                params: { consultant_id:
      #                                                                            consultant.id })
      #   end
      # end

      describe 'GET index' do
        before do
          get :index, {}
        end
        it 'assigns new messages as @messages' do
          assigns(:messages).should be_a_kind_of(Message)
        end
      end

      describe 'GET new' do
        before do
          get :new, consultant_id: consultant.id
        end

        let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:new) }
        it { should respond_with(200) }

        it 'assigns a new form as @form' do
          assigns(:form).should be_a_kind_of(ConversationForm)
        end
      end

      describe 'GET show' do
        let(:conversation) { consultant.send_message(user, 'Test Message Body', 'Test Subject') }

        before do
          get :show, id: conversation.id
        end

        it { should_not redirect_to(new_user_session_path) }
        it { should render_template(:show) }
        it { should respond_with(200) }

        it 'assigns a new message as @message' do
          assigns(:message).should be_a_kind_of(Message)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Conversation' do
            expect do
              post :create, conversation: valid_attributes, consultant_id: consultant.id
            end.to change(Conversation, :count).by(1)
          end

          describe do
            before do
              post :create, conversation: valid_attributes, consultant_id: consultant.id
            end

            it 'assigns a newly created conversation as conversation' do
              assigns(:conversation).should be_a(Conversation)
              assigns(:conversation).should be_persisted
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(conversation_path(conversation)) }
          end
        end
      end

      describe 'as Consultant' do
        let(:user) { FactoryGirl.create(:consultant, :approved) }

        # describe 'download_resume' do
        #   let(:consultant) { FactoryGirl.create(:consultant, :approved, :with_resume) }
        #
        #   before do
        #     consultant.save!
        #     get :download_resume, id: consultant.id
        #   end
        #   it { should redirect_to(consultant.resume.url) }
        # end
      end
    end
  end
end
