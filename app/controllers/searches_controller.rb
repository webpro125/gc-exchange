class SearchesController < ApplicationController
  def new
    if @search.valid?
      Metric.log_search(current_user, @search.attributes) if current_user && !current_user.gces?

      response = Consultant.search(SearchAdapter.new(@search).to_query)
      @consultants = response.page(params[:page]).records
    else
      @consultants = []
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
end
