module ConsultantHelper
  def user_is_gces?
    current_user && current_user.gces?
  end
end
