class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  force_ssl if: :staging_or_production_or_sales?

  before_action :create_search

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:wizard_step) && resource.wizard_step != Wicked::FINISH_STEP
      create_profile_path(resource.wizard_step || Wicked::FIRST_STEP)
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end

  protected

  def staging_or_production_or_sales?
    (Rails.env.staging? || Rails.env.production? || Rails.env.sales?) && action_name !=
      'health_check'
  end

  def create_search
    @search = Search.new search_params
  end

  def search_params
    sanitize_array_param :position_ids
    sanitize_array_param :project_type_ids
    sanitize_array_param :customer_name_ids
    sanitize_array_param :certification_ids
    sanitize_param :clearance_level_id
    sanitize_param :address
    sanitize_param :q
    sanitize_param :term_type

    params.permit(search: [:address, :q, :clearance_level_id, :term_type, position_ids: [],
                           customer_name_ids: [], project_type_ids: [],
                           certification_ids: []])[:search]
  end

  def sanitize_array_param(key)
    return unless params.key? :search

    params[:search][key] ||= []
    params[:search][key].delete ''
  end

  def sanitize_param(key)
    params[:search][key] = nil if params[:search] && params[:search][key].blank?
  end

  def pundit_user
    current_consultant || current_user
  end

  def auth_a_user!
    if consultant_signed_in?
      authenticate_consultant!
    else
      authenticate_user!
    end
  end
  
  # send sms
  def send_sms to_phone, message, consultant
    if consultant.sms_notification
      if to_phone[0] == "0"
        to_phone.sub!("0", '')
      end
      to_number = '+1' + to_phone
      begin
        twilio_client.messages.create(
            to: to_number,
            from: ENV['TWILIO_PHONE_NUMBER'],
            body: message
        )
      rescue Twilio::REST::RequestError => e
        puts e.message
      end

    else
      true
    end
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
end
