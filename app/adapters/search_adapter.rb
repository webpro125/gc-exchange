class SearchAdapter
  GEO_PARAMS = [:address, :distance]
  SHOULD_PARAMS = [:certification_ids, :clearance_level_ids, :clearance_active]
  MUST_PARAMS = [:position_ids, :project_type_ids, :customer_name_ids]
  KEYWORD_PARAMS = [:q]
  PARAM_ID_LOCATION = { position_ids: 'project_histories.project_history_positions.position.id',
                        clearance_level_ids: 'military.clearance_level_id',
                        clearance_active: 'military.clearance_active',
                        project_type_ids: 'project_histories.project_type.id',
                        customer_name_ids: 'project_histories.customer_name.id',
                        certification_ids: 'certification.id' }

  def initialize(params)
    fail ArgumentError unless params.is_a?(Search)
    @params = params
  end

  def to_query
    build_query

    @query[:filter][:and] << build_bool unless build_bool.nil?
    @query[:filter][:and] << build_geo unless build_geo.nil?
    @query[:query] = build_q unless build_q.nil?

    @query
  end

  def build_query
    if !(build_bool.nil? && build_geo.nil?)
      @query = { filter: { and: [] } }
    elsif !build_q.nil?
      @query = { query: {} }
    end
  end

  private

  def build_bool
    must_params = build MUST_PARAMS
    should_params = build SHOULD_PARAMS

    bool = {}
    bool[:must] = build_terms(must_params) unless must_params.empty?
    bool[:should] = build_terms(should_params) unless should_params.empty?

    bool.empty? ? nil : { bool: bool }
  end

  def build_q
    keyword_params = build KEYWORD_PARAMS
    return nil unless @params.q
    { fuzzy_like_this: { fields: [%w(skills_list abstract full_name address description
                                     position_name branch)],
                         like_text: keyword_params[:q],
                         max_query_terms: 20 }
    }
  end

  def build_geo
    return nil unless @params.address && @params.distance

    geo = { geo_distance: { address: {} } }
    geo[:geo_distance][:address] = { lat: @params.lat, lon: @params.lon }
    geo[:geo_distance][:distance] = "#{@params.distance}mi"

    geo
  end

  def build_sort
    [{ updated_at: { order: :desc } },
     { last_sign_in_at: :desc },
     '_score'
    ]
  end

  def build_terms(terms)
    terms_list = terms.map { |k, v| { get_name_from_key(k) => v } }.reduce(:merge)

    return nil if terms_list.empty?

    { terms:  terms_list }
  end

  def get_name_from_key(key)
    PARAM_ID_LOCATION[key]
  end

  def build(list)
    list.each_with_object({}) do |k, obj|
      if @params.respond_to?(k) && !@params.send(k).blank?
        obj[k] = @params.send(k)
      end
      obj
    end
  end
end
