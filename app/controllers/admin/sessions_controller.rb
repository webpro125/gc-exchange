class Admin::SessionsController < Devise::SessionsController
  layout 'admin_devise'

  def new
    @is_login_page = true
    super
  end

  def create
    sign_out :user
    super
  end
end
