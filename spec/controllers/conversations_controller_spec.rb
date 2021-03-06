require 'spec_helper'

describe ConversationsController do
  let(:valid_attributes) do
    { subject: 'Test Subject', message: 'Test message.' }
  end

  describe 'logged in' do
    before do
      sign_in user
    end

    describe 'as User' do
      let!(:consultant) { FactoryGirl.create(:consultant, :approved) }
      let!(:user) { FactoryGirl.create(:user, :with_company) }

      describe 'conversation strong_params' do
        it do
          consultant = FactoryGirl.create(:consultant)
          should permit(:subject, :message).for(:create,
                                                params: { consultant_id:
                                                            consultant.id })
        end
      end

      describe 'message strong_params' do
        let(:conversation) { Mailboxer::Conversation.first }

        it do
          consultant.send_message(user, 'Test Message Body', 'Test Subject')
          should permit(:message).for(:reply,
                                      verb: :post,
                                      params: {
                                        id: conversation.id
                                      })
        end
      end

      describe 'GET index' do
        before do
          get :index, {}
        end
        it 'assigns new messages as @messages' do
          assigns(:messages).should match_array(Mailboxer::Conversation.all)
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
        let(:conversation) { Mailboxer::Conversation.first }

        before do
          consultant.send_message(user, 'Test Message Body', 'Test Subject')
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
              post :create, conversation: valid_attributes, consultant_id: consultant.id,
                   user_id: user.id
            end.to change(Mailboxer::Conversation, :count).by(1)
          end

          describe do
            before do
              post :create, conversation: valid_attributes, consultant_id: consultant.id,
                   user_id: user.id
            end

            it { should_not redirect_to(new_user_session_path) }
            it { should redirect_to(conversation_path(Mailboxer::Conversation.last)) }
          end
        end
      end
    end
  end
end
