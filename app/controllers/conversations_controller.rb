class ConversationsController < ApplicationController
  before_action :recent_consultants
  before_filter :load_consultant, only: [:create]
  before_action :auth_a_user!
  helper_method :mailbox, :conversation
  before_action :get_box, only: [:index]

  def index
    # @messages ||= pundit_user.mailbox.conversations.page(params[:page])
    if @box.eql? "inbox"
      @messages ||= pundit_user.mailbox.inbox.page(params[:page])
    elsif @box.eql? "sent"
      @messages ||= pundit_user.mailbox.sentbox.page(params[:page])
    else
      @messages ||= pundit_user.mailbox.trash
    end
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
    @consultant = conversation.consultant_recipient
    conversation.mark_as_read(pundit_user)
  end

  def reply
    pundit_user.reply_to_conversation(conversation, message_params[:message])
    redirect_to conversation_path(conversation)
  end

  def approve_personal_contact
    current_consultant.shared_contacts.build(user: conversation
                                                     .other_participant(current_consultant),
                                             allowed: true)
    if current_consultant.save
      ProjectStatusMailer.delay.consultant_approved_contact(current_consultant.id, conversation.id)
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

  def message_params
    params.require(:message).permit(:message)
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
