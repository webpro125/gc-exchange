class UploadImagesController < ApplicationController
  before_filter :load_and_authorize

  def create
    @form = UploadImageForm.new(@consultant)

    if @form.validate(consultant_params) && @form.save
      redirect_to consultant_root_path
    else
      render :new
    end
  end

  def new
    @form = UploadImageForm.new(@consultant)
  end

  private

  def pundit_user
    current_consultant || current_user
  end

  def consultant_params
    params.require(:consultant)
  end

  def load_and_authorize
    @consultant = Consultant.find(params[:consultant_id])
    if current_user.present? && current_user.gces?
      authorize current_user, :upload_image?
    else
      authorize current_consultant, :upload_image?
    end
  end
end
