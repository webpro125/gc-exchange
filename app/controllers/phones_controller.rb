class PhonesController < ApplicationController
  before_filter :load_phone, only: [:show, :edit, :update, :destroy]

  def index
    @phones = current_consultant.phones
  end

  def new
    @phone = Phone.new
  end

  def create
    @phone = Phone.new(phone_params)

    if @phone.save
      flash[:success] = t('controllers.phone.create.success')
      redirect_to consultant_root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @phone.update(phone_params)
      flash[:success] = t('controllers.phone.update.success')
      redirect_to consultant_root_path
    else
      render :edit
    end
  end

  def destroy
    @phone.destroy
    redirect_to consultant_root_path
  end

  protected
    def phone_params
      params.require(:phone).permit(:phone_type_id, :number)
    end

    def load_phone
      @phone = current_consultant.phones.find(params[:id])
    end
end
