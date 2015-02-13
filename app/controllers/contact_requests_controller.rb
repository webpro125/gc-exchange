class ContactRequestsController < ConversationsController
  before_filter :authenticate_user!
  before_filter :load_consultant
  helper_method :mailbox, :conversation

  def new
    @contact_request = ContactRequest.new
    @contact_request.build_communication
    @form = ContactRequestForm.new(@contact_request)
  end

  def create
    @contact_request = ContactRequest.new(contact_params)

    if @contact_request.save
      redirect_to consultant_path(@contact_request.consultant)
    else
      render :new
    end
  end

  private

  def load_consultant
    @consultant = Consultant.find(params[:consultant_id])
  end

  def contact_params
    params.require(:contact_request).permit(:subject, :message, :project_start, :project_end,
                                            :project_rate).merge(consultant_id: @consultant.id,
                                                                 user_id: current_user.id)
  end
end
