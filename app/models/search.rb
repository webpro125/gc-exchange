class Search
  include ActiveModel::Model

  VALID_ATTRIBUTES = [:position_ids, :clearance_level_ids, :customer_name_ids, :clearance_active,
                      :project_type_ids, :address, :distance, :lat, :lon].freeze

  attr_accessor :position_ids, :clearance_level_ids, :customer_name_ids, :project_type_ids,
                :address, :distance
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

    @clearance_active = true unless clearance_level_ids.nil? || clearance_level_ids.empty?
    lat_and_long if distance.present? && address.present?
  end

  def at_least_one_attribute
    return unless VALID_ATTRIBUTES.map { |v| send(v) }.reject(&:blank?).size == 0

    errors[:base] << ('One field must be entered to search')
  end

  private

  def lat_and_long
    results = Geocoder.search(address)

    errors[:address] << 'must input a valid address' if results.empty?

    @lat = results.first.latitude
    @lon = results.first.longitude
  end
end
