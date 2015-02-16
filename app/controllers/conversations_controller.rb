class ConversationsController < ApplicationController
  before_action :auth_a_user!
  helper_method :mailbox, :conversation

  def index
    @messages ||= pundit_user.contact_requests.open.page(params[:page])
    # TODO: View other inboxes
  end

  def show
    contact_request
  end

  def interested
    contact_request.assign_attributes(message_params(:message))

    if ContactRequestSetStatus.new(contact_request).interested_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def not_interested
    contact_request.assign_attributes(message_params(:message))

    if ContactRequestSetStatus.new(contact_request).not_interested_and_save
      redirect_to conversations_path
    else
      render :show
    end
  end

  def not_pursuing
    contact_request.assign_attributes(message_params(:message))

    if ContactRequestSetStatus.new(contact_request).not_pursuing_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def hire
    contact_request.assign_attributes(message_params(:message, :project_start, :project_end,
                                                     :project_rate, :project_name,
                                                     :project_location, :travel_authorization_id))

    if ContactRequestSetStatus.new(contact_request).hire_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def agree_to_terms
    if ContactRequestSetStatus.new(contact_request).agree_to_terms_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def reject_terms
    contact_request.assign_attributes(message_params(:message))

    if ContactRequestSetStatus.new(contact_request).reject_terms_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def reply
    pundit_user.reply_to_conversation(conversation, message_params(:message)[:message])
    redirect_to conversation_path(contact_request)
  end

  private

  def mailbox
    @mailbox ||= pundit_user.mailbox
  end

  def contact_request
    @contact_request ||= pundit_user.contact_requests.find(params[:id])

    authorize @contact_request
    @contact_request
  end

  def conversation
    contact_request.communication
  end

  def message_params(*keys)
    params.require(:contact_request).permit(keys)
  end

  def auth_a_user!
    if consultant_signed_in?
      authenticate_consultant!
    else
      authenticate_user!
    end
  end
end
