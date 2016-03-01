class SettingsController < ApplicationController
  before_action :authenticate_consultant!
  before_filter :load_and_authorize_consultant

  def edit
  end

  def update_sms_notification
    @consultant.sms_notification = params[:sms_notification]

    respond_to do |format|
      if @consultant.save
        format.html { redirect_to account_setting_path, notice: t('controllers.setting.update') }
        format.json { render json: account_setting_path, status: :ok, location: @consultant }
      else
        format.html { render action: "edit", notice: @consultant.errors }
        format.json { render json: @consultant.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_and_authorize_consultant
    authorize current_consultant
    @consultant = current_consultant
  end
end
