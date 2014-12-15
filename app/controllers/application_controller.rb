class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  force_ssl if: :not_pages_controller?

  before_action :create_search

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:wizard_step) && resource.wizard_step != Wicked::FINISH_STEP
      create_profile_path(resource.wizard_step || Wicked::FIRST_STEP)
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end

  protected

  def not_pages_controller?
    (Rails.env.staging? || Rails.env.production?) && controller_name != 'pages'
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

    params.permit(search: [:address, :q, :clearance_level_id, position_ids: [],
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
end
