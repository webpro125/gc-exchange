class AddressesController < ApplicationController
  before_filter :load_address, only: [:show, :edit, :update]

  def show
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_consultant.build_address(address_params)

    if @address.save
      redirect_to consultant_root_path, info: t('controllers.address.create_success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to consultant_root_path, info: t('controllers.address.update_success')
    else
      render :edit
    end
  end

  private
    def address_params
      params.require(:address).permit(:address1, :address2, :city, :state, :zipcode)
    end

    def load_address
      @address = current_consultant.address
    end
end
