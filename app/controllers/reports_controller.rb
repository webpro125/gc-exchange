class ReportsController < ApplicationController
  before_filter :get_date_range

  def index
    respond_to do |format|
      format.html {}
      format.json do
        render json: ReportBuilder.new(@from, @to).metrics
      end
    end
  end

  private

  def get_date_range
    @from = params[:from] || Date.today.to_s
    @from = Date.parse(@from).beginning_of_day
    @to   = params[:to] || Date.today.to_s
    @to   = Date.parse(@to).end_of_day
  end
end