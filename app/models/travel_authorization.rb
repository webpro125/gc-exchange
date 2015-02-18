class TravelAuthorization < ActiveRecord::Base
  include Lookup

  NOTAUTH = { code: 'NOTAUTH', label: 'Travel expenses are not authorized' }
  POVAUTH = { code: 'PRIVAUTH', label: 'Privately Owned Vehicle mileage expenses are authorized if
the distance between the consultant’s residence and the project work location exceeds 50 miles' }
  AUTH = { code: 'AUTH', label: 'All travel expenses are authorized in accordance with
client policy' }

  TRAVEL_AUTHORIZATION_TYPES = [NOTAUTH, POVAUTH, AUTH].freeze
end
