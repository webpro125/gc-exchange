class ProfilesController < ConsultantController
  before_filter :load_and_authorize_consultant

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
