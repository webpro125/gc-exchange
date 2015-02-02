module ConsultantHelper
  def user_is_gces?
    current_user && current_user.gces?
  end

  def consultant_owns_record?(consultant)
    return unless current_consultant
    current_consultant == consultant
  end
end
