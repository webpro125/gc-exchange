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
    contact_request.assign_attributes(*message_params(:message))

    if ContactRequestSetStatus.new(contact_request).interested_and_save
      redirect_to conversation_path contact_request
    else
      render :show
    end
  end

  def not_interested
    if ContactRequestSetStatus.new(contact_request).not_interested_and_save
      redirect_to conversations_path
    else
      render :show
    end
  end

  def not_pursuing
    # TODO: not persuing
  end

  def hire
    # TODO: hire
  end

  def agree_to_terms
    # TODO: agree_to_terms
  end

  def reject_terms
    # TODO: reject_terms
  end

  def reply
    pundit_user.reply_to_conversation(conversation, *message_params(:body))
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(pundit_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(pundit_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= pundit_user.mailbox
  end

  def contact_request
    @contact_request ||= pundit_user.contact_requests.find(params[:id])
  end

  def conversation
    contact_request.conversation
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then
        self
      when 1 then
        self[subkeys.first]
      else
        subkeys.map { |k| self[k] }
      end
    end
  end

  def auth_a_user!
    if consultant_signed_in?
      authenticate_consultant!
    else
      authenticate_user!
    end
  end
end
