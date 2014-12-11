require 'reform/form/coercion'

module OtherInformation
  include Reform::Form::Module

  property :rate
  property :willing_to_travel

  validates :rate, numericality: { greater_than: 0, less_than_or_equal_to: 5000 }, presence: true
  validates :willing_to_travel, presence: true

  property :address, populate_if_empty: Address do
    property :address

    validates :address, presence: true, length: { in: 3..512 }
  end

  collection :phones, populate_if_empty: Phone do
    model :phone
    property :number
    property :phone_type_id, type: Integer

    validates :number, presence: true
    validates :phone_type_id, presence: true
  end

  property :military, populate_if_empty: Military do
    property :military
    property :service_start_date, type: DateTime
    property :service_end_date, type: DateTime
    property :investigation_date, type: DateTime
    property :clearance_expiration_date, type: DateTime
    property :clearance_active
    property :clearance_level_id, type: Integer
    property :rank_id, type: Integer
    property :branch_id, type: Integer

    validates :rank_id, presence: true, if: ->() { branch_id.present? }
    validates :branch_id, presence: true, if: ->() { rank_id.present? }
    validates :service_end_date, date: { after: :service_start_date, before: DateTime.now },
              allow_blank: true, if: ->() { service_start_date }
  end
end
