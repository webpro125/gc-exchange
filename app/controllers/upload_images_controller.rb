class UploadImagesController < ApplicationController
  before_filter :load_and_authorize

  def create
    if @form.validate(consultant_params) && @form.save
      if admin_signed_in?
        redirect_to admin_consultant_path(@consultant), notice: t('controllers.consultant.image.success')
      else
        redirect_to consultant_root_path
      end
    else
      render :new
    end
  end

  def new
  end

  private

  def consultant_params
    params.require(:consultant)
  end

  def load_and_authorize
    @consultant = Consultant.find(params[:consultant_id])
    @form = UploadImageForm.new(@consultant)
    unless admin_signed_in?
      # if current_user.present? && current_user.gces?
      #   authorize current_user, :upload_image?
      # else
        authorize current_user.consultant, :upload_image?
      # end
    end
  end
end
