class EducationsController < ConsultantController
  before_filter :load_education, only: [:destroy]

  def new
    @education = current_consultant.educations.build

    authorize @education
  end

  def create
    @education = current_consultant.educations.build(education_params)
    authorize @education

    if @education.save
      flash[:success] = t('controllers.education.create.success')
      redirect_to edit_profile_path
    else
      render :new
    end
  end

  def destroy
    @education.destroy
    redirect_to edit_profile_path
  end

  protected

  def education_params
    params.require(:education).permit(:degree_id, :school, :field_of_study)
  end

  def load_education
    @education = current_consultant.educations.find(params[:id])
    authorize @education
  end
end
