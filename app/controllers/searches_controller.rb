class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @consultants = []

    if @search.valid?
      response = Consultant.search(SearchAdapter.new(@search).to_query)
      @consultants = response.page(params[:page]).records
    else
      render :create
    end
  end

  def skills
    @items = Skill.search(params[:q]).page(params[:page]).records.map do |s|
      { id: s.code, text: s.code }
    end

    respond_to do |f|
      f.json { render json: { items: @items, page: params[:page], total_count: @items.count } }
    end
  end

  private

  def search_params
    sanitize_array_param :position_ids
    sanitize_array_param :clearance_level_ids
    sanitize_array_param :project_type_ids
    sanitize_array_param :customer_name_ids
    sanitize_array_param :certification_ids
    sanitize_param :distance
    sanitize_param :address
    sanitize_param :q

    params.permit(search: [:distance, :address, :q, position_ids: [],
                           clearance_level_ids: [], customer_name_ids: [], project_type_ids: [],
                           certification_ids: []])[:search]
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
