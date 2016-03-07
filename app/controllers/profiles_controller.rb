class ProfilesController < ConsultantController
  before_filter :load_and_authorize_consultant
  before_action :get_box, only: [:consultant]

  def show
    @consultant = current_consultant
  end

  def update
    @form = EditConsultantForm.new(current_consultant)

    if @form.validate(consultant_params) && @form.save
      redirect_to consultant_root_path
    else
      render :edit
    end
  end

  def edit
    @form = EditConsultantForm.new(current_consultant)
  end

  def consultant
    @consultant = current_consultant
    # @conversations = @consultant.mailbox.conversations.page(params[:page])
    if @box.eql? "inbox"
      @conversations ||= @consultant.mailbox.inbox.page(params[:page])
    elsif @box.eql? "sent"
      @conversations ||= @consultant.mailbox.sentbox.page(params[:page])
    else
      @conversations ||= @consultant.mailbox.trash
    end
    @projects = @consultant.projects.open.limit(3)
  end

  private

  def load_and_authorize_consultant
    authorize current_consultant
    current_consultant.build_military unless current_consultant.military.present?
  end

  def consultant_params
    params.require(:consultant)
  end
end
