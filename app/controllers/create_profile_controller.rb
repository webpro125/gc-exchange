class CreateProfileController < ConsultantController
  include Wicked::Wizard

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  steps :basic_information, :qualifications, :other_information, :background_information,
        :project_history

  def show
    generate_show_form

    render_wizard
  end

  def update
    current_consultant.wizard_step = next_step
    generate_update_form

    if @form.validate(form_params(step))
      if params[:save_and_new] && step == :project_history
        @form.save
        current_consultant.save
        redirect_to new_project_history_path
      else
        render_wizard(@form)
      end
    else
      render_wizard
    end
  end

  private

  def finish_wizard_path
    consultant_root_path
  end

  def form_params(sym)
    if sym == :project_history
      params[sym][:position_ids].reject!(&:blank?) if params[sym][:position_ids]
      params.require(sym)
    else
      params.require(:consultant)
    end
  end

  def generate_update_form
    case step
    when :basic_information
      @form = BasicInformationForm.new current_consultant
    when :qualifications
      @form = QualificationsForm.new current_consultant
    when :other_information
      @form = OtherInformationForm.new current_consultant
    when :background_information
      @form = BackgroundInformationForm.new current_consultant
    when :project_history
      @form = ProjectHistoryForm.new current_consultant.project_histories.build
    end
  end

  def generate_show_form
    case step
    when :basic_information
      @form = BasicInformationForm.new current_consultant
    when :qualifications
      current_consultant.educations.build
      @form = QualificationsForm.new current_consultant
    when :other_information
      generate_other_information
      @form = OtherInformationForm.new current_consultant
    when :background_information
      current_consultant.build_background unless current_consultant.background.present?
      @form = BackgroundInformationForm.new current_consultant
    when :project_history
      @form = ProjectHistoryForm.new current_consultant.project_histories.build
    end
  end

  def generate_other_information
    current_consultant.phones.build
    current_consultant.build_address unless current_consultant.address.present?
  end
end
