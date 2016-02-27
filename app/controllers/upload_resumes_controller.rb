class UploadResumesController < ApplicationController
  before_filter :load_and_authorize

  def create
    if @form.validate(consultant_params) && @form.save
      if admin_signed_in?
        redirect_to admin_consultant_path(@consultant), notice: t('controllers.create_profile.create.success')
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
    @form = UploadResumeForm.new(@consultant)
    unless admin_signed_in?
      if current_user.present? && current_user.gces?
        authorize current_user, :upload_resume?
      else
        authorize current_consultant, :upload_resume?
      end
    end
  end
end
