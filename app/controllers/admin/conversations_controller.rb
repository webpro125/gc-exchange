class Admin::ConversationsController < ApplicationController
  before_action :recent_consultants
  before_filter :load_consultant, only: [:create, :new]
  before_action :authenticate_admin!
  helper_method :mailbox, :conversation
  layout 'application_admin'

  def index
    @conversations ||= current_admin.mailbox.conversations.page(params[:page])
  end

  def new
    @form = ConversationForm.new(Message.new)
  end

  def create
    @form = ConversationForm.new(Message.new)

    if @form.validate(conversation_form_params)
      conversation = current_admin.send_message(@consultant,
                                               conversation_form_params[:message],
                                               conversation_form_params[:subject]).conversation
      redirect_to admin_conversation_path(conversation), notice: t('controllers.conversation.create')
    else
      render :new
    end
  end

  def show
    @message    = Message.new
    # @consultant = conversation.consultant_recipient
    conversation
  end

  def reply
    current_admin.reply_to_conversation(conversation, message_params[:message])
    redirect_to admin_conversation_path(conversation)
  end

  private

  def mailbox
    @mailbox ||= current_admin.mailbox
  end

  def conversation
    @conversation ||= current_admin.mailbox.conversations.find(params[:id])
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
