class ConsultantProjectsController < ApplicationController
  before_action :auth_a_user!
  before_action :consultants
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = pundit_user.consultant.projects.page(params[:page])
  end

  def show

  end

  def not_interested
    if ProjectSetStatus.new(@project).not_interested_and_save
      redirect_to consultant_projects_path
    else
      render :show
    end
  end

  def agree_to_terms
    if ProjectSetStatus.new(@project).agree_to_terms_and_save
      redirect_to consultant_projects_path
    else
      render :show
    end
  end

  def reject_terms
    if ProjectSetStatus.new(@project).under_revision_and_save
      redirect_to consultant_projects_path
    else
      render :show
    end
  end

  private

  def consultants
    @consultants = Consultant.recent
  end

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end
end
