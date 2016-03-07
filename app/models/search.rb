class Search
  include ActiveModel::Model

  VALID_ATTRIBUTES = [:position_ids, :clearance_level_id, :customer_name_ids, :clearance_active,
                      :project_type_ids, :address, :distance, :lat, :lon, :certification_ids,
                      :q].freeze

  # q - query.  searches the whole consultant document
  attr_accessor :position_ids, :clearance_level_id, :customer_name_ids, :project_type_ids,
                :address, :distance, :certification_ids, :q, :clearance_level_ids
  attr_reader :lat, :lon, :attributes, :clearance_active

  validates :distance, presence: true, numericality: { greater_than: 0 },
            if: ->() { address.present? }
  validates :address, presence: true, if: ->() { distance.present? }
  validate :at_least_one_attribute

  def initialize(params = {})
    params ||= {}

    nil_attributes = Hash[*VALID_ATTRIBUTES.map { |v| [v, nil] }.flatten]
    @attributes = params.symbolize_keys.select do |k, _|
      VALID_ATTRIBUTES.include? k
    end.reverse_merge(nil_attributes)

    super

    @clearance_active = [true] unless @clearance_level_id.nil?
    lat_and_long if address.present?
    self.distance = 50 if address.present?
    cascade_clearance_levels
  end

  def at_least_one_attribute
    return unless VALID_ATTRIBUTES.map { |v| send(v) }.reject(&:blank?).size == 0

    errors[:base] << ('One field must be entered to search')
  end

  def cascade_clearance_levels
    case @clearance_level_id.to_i
    when ClearanceLevel.secret.id
      self.clearance_level_ids = ClearanceLevel.pluck(:id).map(&:to_s)
    when ClearanceLevel.ts.id
      self.clearance_level_ids = [clearance_level_id.to_s, ClearanceLevel.ts_sci.id.to_s]
    when ClearanceLevel.ts_sci.id
      self.clearance_level_ids = [ClearanceLevel.ts_sci.id.to_s]
    end
  end

  def metrics
    attributes.select { |_, value| value.present? }
  end

  private

  def lat_and_long
    results = Geocoder.search(address)

    errors[:address] << 'must input a valid address' if results.empty?

    @lat = results.first.latitude
    @lon = results.first.longitude
  end
end
