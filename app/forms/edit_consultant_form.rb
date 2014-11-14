require 'reform/form/coercion'

class EditConsultantForm < Reform::Form
  include Reform::Form::ModelReflections, Qualifications

  model :consultant

  property :first_name
  property :last_name
  property :rate
  property :abstract
  property :willing_to_travel

  validates :willing_to_travel, presence: true
  validates :rate, numericality: { greater_than: 0 }, presence: true
  validates :abstract, length: { maximum: 1500 }
  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_DASHES,
                      message: 'only allows letters' }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: 'only allows letters and numbers' }
  validates :abstract, length: { maximum: 1500 }

  property :address, populate_if_empty: Address do
    property :address

    validates :address, presence: true, length: { in: 3..512 }
  end

  collection :phones, populate_if_empty: Phone do
    property :number
    property :phone_type_id, type: Integer

    validates :number, presence: true
    validates :phone_type_id, presence: true
  end

  property :military, populate_if_empty: Military do
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

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end

  def new_record?
    @model.new_record?
  end
end
