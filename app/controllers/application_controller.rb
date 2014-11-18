class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  def after_sign_in_path_for(resource)
    if resource.respond_to?(:wizard_step) && resource.wizard_step != Wicked::FINISH_STEP
      create_profile_path(resource.wizard_step || Wicked::FIRST_STEP)
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end
end
