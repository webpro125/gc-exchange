class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    sign_out :admin
    super
  end
end
