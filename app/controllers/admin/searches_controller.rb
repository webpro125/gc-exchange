class Admin::SearchesController < SearchesController
  layout 'application_admin'
  before_action :authenticate_admin!
  def index

  end
  def new
    super
  end
end
