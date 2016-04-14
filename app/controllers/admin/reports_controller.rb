class Admin::ReportsController < Admin::BaseController
  before_filter :get_date_range

  def public
    respond_to do |format|
      format.html {}
      format.json do
        render json: ReportBuilder.new(@from, @to, @filter).public_metrics
      end
    end
  end

  def consultant
    respond_to do |format|
      format.html {}
      format.json do
        render json: ReportBuilder.new(@from, @to, @filter).consultant_metrics
      end
    end
  end

  def search
    respond_to do |format|
      format.html {}
      format.json do
        render json: ReportBuilder.new(@from, @to, @filter).search_metrics
      end
    end
  end

  private

  def get_date_range
    @from = params[:from] || Date.today.to_s
    @from = Date.parse(@from).beginning_of_day
    @to   = params[:to] || Date.today.to_s
    @to   = Date.parse(@to).end_of_day
    @filter = params[:filter] || 'day'
  end
end