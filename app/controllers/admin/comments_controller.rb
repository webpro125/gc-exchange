class Admin::CommentsController < CommentsController
  layout 'application_admin'
  before_action :authenticate_admin!

  def index
    super
  end

  def create
    super
  end

  def update
    super
  end

  def load_comment
    super
  end
end