class ConversationsController < ApplicationController
  before_filter :load_consultant, only: [:create]
  before_action :auth_a_user!
  helper_method :mailbox, :conversation

  def index
    # @messages ||= pundit_user.mailbox.inbox.open.page(params[:page])
    # TODO: View other inboxes
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
    @message = Message.new
    conversation
  end

  def reply
    pundit_user.reply_to_conversation(conversation, message_params(:message)[:message])
    redirect_to conversation_path(conversation)
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

  def conversation_params(*keys)
    params.require(:conversation, *keys)
  end

  def conversation_form_params
    params.require(:conversation).permit(:subject, :message)
  end

  def load_consultant
    @consultant = Consultant.find(params[:consultant_id])
  end

  def project_params
    params.require(:project).permit(:subject, :message, :project_start, :project_end,
                                    :project_rate).merge(consultant_id: @consultant.id,
                                                         user_id: current_user.id)
  end

  def update_communication
    if current_consultant?
      current_consultant.reply_to_conversation(conversation, message)
    else
      current_user.reply_to_conversation(conversation, message)
    end
  end
end
