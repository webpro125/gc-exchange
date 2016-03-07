class Admin::ConversationsController < ApplicationController
  before_action :authenticate_admin!
  before_action :recent_consultants
  before_filter :load_consultant, only: [:create, :new]
  before_action :get_box, only: [:index]
  helper_method :mailbox, :conversation
  layout 'application_admin'

  def index
    if @box.eql? "inbox"
      @conversations ||= mailbox.inbox.page(params[:page])
    elsif @box.eql? "sent"
      @conversations ||= mailbox.sentbox.page(params[:page])
    else
      @conversations ||= mailbox.trash
    end
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
    @conversation.mark_as_read(current_admin)
  end

  def reply
    current_admin.reply_to_conversation(conversation, message_params[:message])
    redirect_to admin_conversation_path(conversation)
  end

  def destroy
    conversation.move_to_trash(current_admin)
    redirect_to admin_conversations_path, notice: t('controllers.conversation.destroy.success')
  end

  def restore
    conversation.untrash(current_admin)
    redirect_to admin_conversations_path, notice: t('controllers.conversation.restore.success')
  end

  def empty_trash
    mailbox.trash.each do |conversation|
      conversation.receipts_for(current_admin).update_all(deleted: true)
    end
    redirect_to admin_conversations_path, notice: t('controllers.conversation.empty_to_trash.success')
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

