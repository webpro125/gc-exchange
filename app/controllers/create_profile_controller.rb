class CreateProfileController < ConsultantController
  include Wicked::Wizard

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  skip_before_action :consultant_wizard_redirect

  before_action :redirect_after_wizard

  steps :howto, :basic_information, :qualifications, :other_information, :background_information,
        :howto_projects, :project_history, :contract_begin, :contract

  def show
    generate_show_form
    render_wizard
  end

  def update
    current_consultant.wizard_step = next_step
    generate_update_form

    if @form.validate(form_params(step))
      if step == :background_information
        render_background_information
      else
        render_wizard_path
      end
    else
      render_wizard
    end
  end

  private

  def finish_wizard_path
    profile_completed_path
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
      @form = ProjectHistoryForm.new current_consultant.project_histories.first_or_initialize
    when :contract
      current_consultant.contract_effective_date = DateTime.now
      @form = EditConsultantForm.new current_consultant
    end
  end

  def generate_show_form
    case step
    when :basic_information
      @form = BasicInformationForm.new current_consultant
    when :qualifications
      generate_qualifications_show
    when :other_information
      generate_other_information
    when :background_information
      generate_background_information
    when :project_history
      generate_project_history
    when :contract
      @form = EditConsultantForm.new current_consultant
    end
  end

  def generate_other_information
    current_consultant.build_address unless current_consultant.address.present?
    current_consultant.build_military unless current_consultant.military.present?
    @form = OtherInformationForm.new current_consultant
  end

  def generate_qualifications_show
    @form = QualificationsForm.new current_consultant
  end

  def generate_background_information
    current_consultant.build_background unless current_consultant.background.present?
    @form = BackgroundInformationForm.new current_consultant
  end

  def generate_project_history
    project = current_consultant.project_histories.first_or_initialize
    project.build_phone if project.phone.nil?

    @form = ProjectHistoryForm.new project
  end

  def redirect_after_wizard
    return unless current_consultant.wizard_step == Wicked::FINISH_STEP
    redirect_to finish_wizard_path
    false
  end

  def render_background_information
    @form.save
    ConsultantSetStatus.new(current_consultant).on_hold_and_save
    render_wizard_path
  end

  def render_wizard_path
    render_wizard(@form)
    ConsultantSetStatus.new(current_consultant).pending_approval_and_save if step == :contract
  end
end
