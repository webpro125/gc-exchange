class Address < ActiveRecord::Base
  include RegexLibary
  includes :state
  belongs_to :consultant

  validates :address1, presence: true, length: { in: 4..128 }
  validates :address2, length: { in: 4..128 }, allow_blank: true
  validates :city, presence: true, length: { in: 3..64 }, format: { with: LETTERS['and spaces'],
                                                                    message: 'only allows letters' }
  validates :state, presence: true, length: { is: 2 }, format: { with: LETTERS['only'],
                                                                 message: 'only allows letters' }
  validates :zipcode, presence: true, length: { is: 5 }, format: { with: NUMBERS['as a zipcode'],
                                                                   message: 'must be zipcode' }
  validates :consultant_id, presence: true
  validate :validate_state

  # Geocoder
  geocoded_by :full_street_address
  after_validation :geocode, if: :address_changed?

  private

  def full_street_address
    [address1, address2, city, state, zipcode].join(', ')
  end

  def address_changed?
    address1_changed? || address2_changed? || city_changed? || state_changed? ||
    zipcode_changed?
  end

  def validate_state
    return if State::STATE_TYPES.include?(state)
    errors.add(:state, I18n.t('activerecord.errors.models.address.attributes.state.match_fail'))
  end
end
