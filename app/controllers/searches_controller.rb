class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @consultants = []

    if @search.valid?
      response = Consultant.search(SearchAdapter.new(@search).to_query)
      @consultants = response.page(params[:page]).records.to_a
    else
      render :create
    end
  end

  private

  def search_params
    sanitize_array_param :position_ids
    sanitize_array_param :clearance_level_ids
    sanitize_array_param :customer_name_ids
    sanitize_array_param :discipline_ids
    sanitize_param :distance
    sanitize_param :address

    params.permit(search: [:clearance_active, :distance, :address, position_ids: [],
                           clearance_level_ids: [], customer_name_ids: [],
                           discipline_ids: []])[:search]
  end

  def sanitize_array_param(key)
    return unless params.key? :search

    params[:search][key] ||= []
    params[:search][key].delete ''
  end

  def sanitize_param(key)
    params[:search][key] = nil if params[:search] && params[:search][key].blank?
  end
end
