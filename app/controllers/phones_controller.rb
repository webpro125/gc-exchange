class PhonesController < ConsultantController
  before_filter :load_phone, only: [:destroy]

  def new
    @phone = current_consultant.phones.build
    @phone_types = PhoneType.all

    authorize @phone
  end

  def create
    @phone = current_consultant.phones.build(phone_params)
    authorize @phone

    if PhoneUnsetPrimaries.new(@phone).save
      flash[:success] = t('controllers.phone.create.success')
      redirect_to edit_profile_path
    else
      render :new
    end
  end

  def destroy
    if current_consultant.phones > 1
      @phone.destroy
    else
      flash[:error] = t('controllers.phone.destroy.failure')
    end
    redirect_to edit_profile_path
  end

  protected

  def phone_params
    params.require(:phone).permit(:phone_type_id, :number, :primary)
  end

  def load_phone
    @phone = current_consultant.phones.find(params[:id])
    authorize @phone
  end
end
