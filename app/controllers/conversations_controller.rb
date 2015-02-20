class ConversationsController < ApplicationController
  before_filter :load_consultant, only: [:create]
  before_action :auth_a_user!
  helper_method :mailbox, :conversation

  def index
    # @messages ||= pundit_user.mailbox.inbox.all.open.page(params[:page])
    # @messages ||= pundit_user.mailbox.inbox.all
    # TODO: View other inboxes
  end

  def new
    @form = ConversationForm.new(Message.new)
  end

  def create
    @form = ConversationForm.new(Message.new)

    if @form.validate(conversation_form_params)
      conversation = current_user.send_message(@consultant,
                                               params[:conversation][:message],
                                               params[:conversation][:subject]).conversation
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

  # def interested
  #   contact_request.assign_attributes(message_params(:message))
  #
  #   if ProjectSetStatus.new(contact_request).interested_and_save
  #     redirect_to conversation_path contact_request
  #   else
  #     render :show
  #   end
  # end
  #
  # def not_interested
  #   contact_request.assign_attributes(message_params(:message))
  #
  #   if ProjectSetStatus.new(contact_request).not_interested_and_save
  #     redirect_to conversations_path
  #   else
  #     render :show
  #   end
  # end
  #
  # def not_pursuing
  #   contact_request.assign_attributes(message_params(:message))
  #
  #   if ProjectSetStatus.new(contact_request).not_pursuing_and_save
  #     redirect_to conversation_path contact_request
  #   else
  #     render :show
  #   end
  # end
  #
  # def hire
  #   contact_request.assign_attributes(message_params(:message, :project_start, :project_end,
  #                                                    :project_rate, :project_name,
  #                                                    :project_location, :travel_authorization_id))
  #
  #   if ProjectSetStatus.new(contact_request).hire_and_save
  #     redirect_to conversation_path contact_request
  #   else
  #     render :show
  #   end
  # end
  #
  # def agree_to_terms
  #   if ProjectSetStatus.new(contact_request).agree_to_terms_and_save
  #     redirect_to conversation_path contact_request
  #   else
  #     render :show
  #   end
  # end
  #
  # def reject_terms
  #   contact_request.assign_attributes(message_params(:message))
  #
  #   if ProjectSetStatus.new(contact_request).reject_terms_and_save
  #     redirect_to conversation_path contact_request
  #   else
  #     render :show
  #   end
  # end

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

  def auth_a_user!
    if consultant_signed_in?
      authenticate_consultant!
    else
      authenticate_user!
    end
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
