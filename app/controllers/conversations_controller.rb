class ConversationsController < ApplicationController
  before_action :recent_consultants
  before_filter :load_consultant, only: [:create]
  before_action :authenticate_user!
  helper_method :mailbox, :conversation
  before_action :get_box, only: [:index]

  def index
    @new_design = true

    if @box.eql? "inbox"
      @q ||= current_user.mailbox.inbox.ransack(params[:q])
      @messages ||= @q.result.page(params[:page])
    elsif @box.eql? "sent"
      @q ||= current_user.mailbox.sentbox.ransack(params[:q])
      @messages ||= @q.result.page(params[:page])
    elsif @box.eql? "flagged"
      @q ||= current_user.mailbox.flag.ransack(params[:q])
      @messages ||= @q.result.page(params[:page])
    else
      @q = current_user.mailbox.trash.ransack(params[:q])
      @messages ||= @q.result.page(params[:page])
    end

    # @q.sorts = 'id asc' if @q.sorts.empty?
    unless params[:keyword].blank?
      @messages = conversations_for(params[:keyword])
    end
    @mailbox_unread_count = current_user.mailbox.inbox(:read => false).count(:id, :distinct => true)
    @message    = Message.new

    render layout: 'conversation'

  end

  def new
    @new_design = true
    @form = ConversationForm.new(Message.new)
  end

  def create
    @form = ConversationForm.new(Message.new)

    if @form.validate(conversation_form_params)
      conversation = current_user.send_message(@consultant.user,
                                               conversation_form_params[:message],
                                               conversation_form_params[:subject]).conversation
      redirect_to conversation_path(conversation)
    else
      render :new
    end
  end

  def show
    @message    = Message.new
    # @consultant = conversation.consultant_recipient
    conversation.mark_as_read(pundit_user)
  end

  def reply
    pundit_user.reply_to_conversation(conversation, message_params[:message], nil, true, true, message_params[:attachment])
    # redirect_to conversation_path(conversation)
    redirect_to conversations_path(active_id: conversation.id, box: 'sent')
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

  def destroy
    conversation.move_to_trash(pundit_user)
    redirect_to conversations_path, notice: t('controllers.conversation.destroy.success')
  end

  def restore
    conversation.untrash(pundit_user)
    redirect_to conversations_path, notice: t('controllers.conversation.restore.success')
  end

  def empty_trash
    mailbox.trash.each do |conversation|
      conversation.receipts_for(pundit_user).update_all(deleted: true)
    end
    redirect_to conversations_path, notice: t('controllers.conversation.empty_to_trash.success')
  end

  def read_conversation
    conversation.mark_as_read(pundit_user)
    render json: @conversation, status: :ok
  end

  def mark_flag
    conversation.mark_as_flag(pundit_user)
    redirect_to conversations_path, notice: t('controllers.conversation.flag.success')
  end

  def remove_mark_flag
    conversation.mark_as_unflag(pundit_user)
    redirect_to conversations_path, notice: t('controllers.conversation.unflag.success')
  end

  private

  def mailbox
    @mailbox ||= pundit_user.mailbox
  end

  def conversation
    @conversation ||= pundit_user.mailbox.conversations.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message, :attachment)
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

  def conversations_for(query)
    wildcarded_query = "%#{query}%"
    user_ids = User.where('CONCAT(first_name,  last_name) LIKE :query', query: wildcarded_query).pluck(:id)
    conv_ids = current_user.mailbox.conversations.
        joins(:messages).
        references('mailboxer_conversations, mailboxer_notifications, mailboxer_receipts, messages_mailboxer_conversations, mr, mn'). # To get rid of warnings
    select('mailboxer_conversations.*, mailbox_type, trashed').
        where("mailboxer_notifications.subject LIKE :query
                              OR mailboxer_notifications.body LIKE :query
                              OR mailboxer_notifications.sender_id IN (:user_ids)
                              OR EXISTS ( SELECT * FROM mailboxer_receipts mr
                                                   INNER JOIN mailboxer_notifications mn ON mn.id = mr.notification_id
                                                   WHERE mn.conversation_id = mailboxer_conversations.id
                                                   AND mr.notification_id IN ( SELECT id FROM mailboxer_notifications
                                                                                           WHERE sender_id = :current_user_id )
                                                   AND mr.receiver_id IN (:user_ids))",
              query: wildcarded_query, user_ids: user_ids, current_user_id: current_user.id).map(&:id).uniq
    pundit_user.mailbox.conversations.find(conv_ids)
  end
end
