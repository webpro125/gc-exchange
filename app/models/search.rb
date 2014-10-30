class Search
  include ActiveModel::Model

  VALID_ATTRIBUTES = [:position_ids, :clearance_level_ids, :customer_name_ids, :clearance_active,
                      :project_type_ids, :address, :distance, :lat, :lon, :certification_ids].freeze

  attr_accessor :position_ids, :clearance_level_ids, :customer_name_ids, :project_type_ids,
                :address, :distance, :certification_ids
  attr_reader :lat, :lon, :attributes, :clearance_active

  validates :distance, presence: true, numericality: { greater_than: 0 },
            if: ->() { address.present? }
  validates :address, presence: true, if: ->() { distance.present? }
  validate :at_least_one_attribute
  validate :clearance_id_default, if: ->() { clearance_level_ids.present? }

  def initialize(params = {})
    params ||= {}

    nil_attributes = Hash[*VALID_ATTRIBUTES.map { |v| [v, nil] }.flatten]
    @attributes = params.symbolize_keys.select do |k, _|
      VALID_ATTRIBUTES.include? k
    end.reverse_merge(nil_attributes)

    super

    # @clearance_active ||= []
    # @clearance_active[0] = true unless clearance_level_ids.nil? || clearance_level_ids.empty?
    @clearance_active = [true] unless clearance_level_ids.nil? || clearance_level_ids.empty?
    lat_and_long if distance.present? && address.present?
  end

  def at_least_one_attribute
    return unless VALID_ATTRIBUTES.map { |v| send(v) }.reject(&:blank?).size == 0

    errors[:base] << ('One field must be entered to search')
  end

  def clearance_id_default
    if clearance_level_ids[0] == ClearanceLevel.find_by_code(ClearanceLevel::SECRET).id.to_s
      clearance_level_ids[1] = ClearanceLevel.find_by_code(ClearanceLevel::TS).id.to_s
      clearance_level_ids[2] = ClearanceLevel.find_by_code(ClearanceLevel::TSSCI).id.to_s
    elsif clearance_level_ids[0] == ClearanceLevel.find_by_code(ClearanceLevel::TS).id.to_s
      clearance_level_ids[1] = ClearanceLevel.find_by_code(ClearanceLevel::TSSCI).id.to_s
    end
  end

  private

  def lat_and_long
    results = Geocoder.search(address)

    errors[:address] << 'must input a valid address' if results.empty?

    @lat = results.first.latitude
    @lon = results.first.longitude
  end
end
