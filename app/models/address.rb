class Address < ActiveRecord::Base
  include Indexable

  belongs_to :consultant

  validates :consultant, presence: true
  validate :validate_geocode

  before_validation :reset_lat_and_lon, if: :address_changed?
  before_validation :geocode, if: :address_changed?

  # Geocoder
  geocoded_by :address

  def lat
    latitude
  end

  def lon
    longitude
  end

  private

  def validate_geocode
    return unless latitude.nil? && longitude.nil?
    errors.add(:address, I18n.t('activerecord.errors.models.address.attributes.geocode_fail'))
  end

  def reset_lat_and_lon
    self.latitude = nil
    self.longitude = nil
  end
end
