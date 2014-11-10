class CreateProfileController < ConsultantController
  include Wicked::Wizard

  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  steps :basic_information, :qualifications, :other_information, :project_history

  def show
    render_wizard
  end

  def update
    current_consultant.wizard_step = next_step

    render_wizard # (current_consultant.save)
  end

  private

  def finish_wizard_path
    consultant_root_path
  end
end
