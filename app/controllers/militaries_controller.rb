class MilitariesController < ConsultantController
  before_filter :load_military, only: [:update, :destroy]

  def new
    @military = current_consultant.military || current_consultant.build_military
    authorize @military
  end

  def create
    @military = current_consultant.build_military(military_params)
    authorize @military

    if @military.save
      flash[:success] = t('controllers.military.create.success')
      redirect_to consultant_root_path
    else
      render :new
    end
  end

  def update
    if @military.update(military_params)
      flash[:success] = t('controllers.military.update.success')
      redirect_to consultant_root_path
    else
      render :update
    end
  end

  protected

  def military_params
    params.require(:military).permit(:investigation_date,
                                     :clearance_expiration_date,
                                     :service_start_date,
                                     :service_end_date)
  end

  def load_military
    @military = current_consultant.military
    authorize @military

    redirect_to new_military_path if @military.new_record?
  end
end
