class ProfilesController < ConsultantController
  before_filter :load_and_authorize_consultant
  before_action :get_box, only: [:consultant]

  def show
    @consultant = current_user.consultant
  end

  def update
    @form = EditConsultantForm.new(current_user)

    if @form.validate(consultant_params) && @form.save
      redirect_to consultant_root_path
    else
      render :edit
    end
  end

  def edit
    @form = EditConsultantForm.new(current_user)
  end

  def consultant
    @consultant = current_user.consultant
    # @conversations = @consultant.mailbox.conversations.page(params[:page])
    if @box.eql? "inbox"
      @conversations ||= current_user.mailbox.inbox.page(params[:page])
    elsif @box.eql? "sent"
      @conversations ||= current_user.mailbox.sentbox.page(params[:page])
    else
      @conversations ||= current_user.mailbox.trash
    end
    @consultant_projects = @consultant.projects.open.limit(3)
  end

  private

  def load_and_authorize_consultant
    authorize current_user.consultant
    current_user.consultant.build_military unless current_user.consultant.military.present?
  end

  def consultant_params
    params.require(:user)
  end
end
