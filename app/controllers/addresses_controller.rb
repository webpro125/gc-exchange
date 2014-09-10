class AddressesController < ConsultantController
  before_filter :load_address, only: [:edit, :update]

  def new
    @address = current_consultant.address || current_consultant.build_address
    authorize @address

    redirect_to edit_address_path unless @address.new_record?
  end

  def create
    @address = current_consultant.build_address(address_params)
    authorize @address

    if @address.save
      flash[:success] = t('controllers.address.create.success')
      redirect_to consultant_root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:success] = t('controllers.address.update.success')
      redirect_to consultant_root_path
    else
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:address1, :address2, :city, :state, :zipcode)
  end

  def load_address
    @address = current_consultant.address || current_consultant.build_address
    authorize @address

    redirect_to new_address_path if @address.new_record?
  end
end
