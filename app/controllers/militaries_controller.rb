class MilitariesController < ConsultantController
  before_filter :load_military, only: [:update, :destroy]

  def create
    @military = current_consultant.build_military(military_params)
    authorize @military

    @military.save
    flash[:success] = t('controllers.military.create.success')
    redirect_to consultant_root_path
  end

  def update
    @military.update(military_params)
    flash[:success] = t('controllers.military.update.success')
    redirect_to consultant_root_path
  end

  protected

  def military_params
    params.require(:military).permit(:investigation_date,
                                     :clearance_expiration_date,
                                     :service_start_date,
                                     :service_end_date,
                                     :rank_id,
                                     :branch_id,
                                     :clearance_level_id)
  end

  def load_military
    @military = current_consultant.military
    authorize @military
  end
end
