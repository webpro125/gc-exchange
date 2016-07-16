class Admin::ConsultantsController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!
  add_breadcrumb 'Consultants', :admin_consultants_path

  def index
    # @consultants_grid = initialize_grid(Consultant,
    #                                    order: 'created_at',
    #                                    order_direction: 'desc',
    #                                    per_page: 10,
    #                                    name: 'g1',
    #                                    enable_export_to_csv: true,
    #                                    csv_field_separator: ',',
    #                                    csv_file_name: 'consultants'
    # )
    #
    # export_grid_if_requested('g1' => 'consultants_grid') do
    #   # usual render or redirect code executed if the request is not a CSV export request
    # end
    @q = Consultant.search(params[:q])
    @q.sorts = 'id asc' if @q.sorts.empty?
    @consultants = @q.result.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv  { send_data Consultant.to_csv }
      format.xls  { send_data Consultant.to_csv(col_sep: "\t") }
    end
  end

  def show
    @consultant = Consultant.find(params[:id])
    add_breadcrumb @consultant.full_name
    @form = UploadResumeForm.new(@consultant)
  end

  def approve
    @consultant = Consultant.find(params[:id])
    if ConsultantSetStatus.new(@consultant).approve_and_save
      redirect_to admin_consultant_path(@consultant), notice: t('controllers.consultant.approve.success')
    else
      redirect_to admin_consultant_path(@consultant), notice: t('controllers.consultant.approve.fail')
    end
  end

  def reject
    @consultant = Consultant.find(params[:id])
    if ConsultantSetStatus.new(@consultant).reject_and_save
      redirect_to admin_consultant_path(@consultant), notice: t('controllers.consultant.reject.success')
    else
      redirect_to admin_consultant_path(@consultant), notice: t('controllers.consultant.reject.fail')
    end
  end
end
