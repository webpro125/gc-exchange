class SearchAdapter
  GEO_PARAMS = [:address, :distance]
  MUST_PARAMS = [:position_ids, :clearance_level_ids, :clearance_active]
  SHOULD_PARAMS = [:project_type_ids, :customer_name_ids]

  def initialize(params)
    fail ArgumentError unless params.is_a?(Search)
    @params = params
  end

  def to_query
    query = { filter: { and: [] } }

    query[:filter][:and] << build_bool unless build_bool.nil?
    query[:filter][:and] << build_geo unless build_geo.nil?

    query
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
    case key
    when :position_ids
      'project_histories.project_history_positions.position.id'
    when :clearance_level_ids
      'military.clearance_level_id'
    when :clearance_active
      'military.clearance_active'
    when :project_type_ids
      'project_histories.project_type.id'
    when :customer_name_ids
      'project_histories.customer_name.id'
    end
  end

  def build(list)
    list.each_with_object({}) do |k, obj|
      if @params.respond_to?(k) && !@params.send(k).nil?
        obj[k] = @params.send(k)
      end
      obj
    end
  end
end
