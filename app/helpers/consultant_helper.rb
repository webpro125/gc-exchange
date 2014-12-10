module ConsultantHelper
  def user_is_gces?
    current_user && current_user.gces?
  end

  def consultant_owns_record?
    return unless current_consultant
    current_consultant.id == @consultant.id
  end
end
