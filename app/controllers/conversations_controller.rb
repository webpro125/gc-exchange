class ConversationsController < ApplicationController
  before_action :recent_consultants
  before_filter :load_consultant, only: [:create]
  before_action :auth_a_user!
  helper_method :mailbox, :conversation

  def index
    @messages ||= pundit_user.mailbox.inbox.page(params[:page])
  end

  def new
    @form = ConversationForm.new(Message.new)
  end

  def create
    @form = ConversationForm.new(Message.new)

    if @form.validate(conversation_form_params)
      conversation = current_user.send_message(@consultant,
                                               conversation_form_params[:message],
                                               conversation_form_params[:subject]).conversation
      redirect_to conversation_path(conversation)
    else
      render :new
    end
  end

  def show
    @message    = Message.new
    @consultant = conversation.recipients.select { |r| r.is_a? Consultant }.first
  end

  def reply
    pundit_user.reply_to_conversation(conversation, message_params(:message)[:message])
    redirect_to conversation_path(conversation)
  end

  def approve_personal_contact
    current_consultant.shared_contacts.build(user: conversation
                                                     .other_participant(current_consultant.id),
                                             allowed: true)
    if shared_contact.save
      redirect_to conversation_path(conversation), notice: 'Approved Contact'
    else
      redirect_to conversation_path(conversation), notice: 'Unable to Approve Contact'
    end
  end

  private

  def mailbox
    @mailbox ||= pundit_user.mailbox
  end

  def conversation
    @conversation ||= pundit_user.mailbox.conversations.find(params[:id])
  end

  def message_params(*keys)
    params.require(:message).permit(keys)
  end

  def conversation_form_params
    params.require(:conversation).permit(:subject, :message)
  end

  def load_consultant
    @consultant = Consultant.find(params[:consultant_id])
  end

  def recent_consultants
    @consultants = Consultant.recent
  end
end
