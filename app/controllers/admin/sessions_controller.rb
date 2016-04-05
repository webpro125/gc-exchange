class Admin::SessionsController < Devise::SessionsController
  layout 'application_admin'
  def new
    @is_login_page = true
    super
  end

  def create
    sign_out :user
    super
  end
end
