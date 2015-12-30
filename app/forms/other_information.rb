require 'reform/form/coercion'

module OtherInformation
  include Reform::Form::Module

  property :rate
  property :willing_to_travel

  validates :rate, numericality: { greater_than: 0, less_than_or_equal_to: 5_000 }, presence: true
  validates :willing_to_travel, presence: true

  property :entity, populate_if_empty: Entity do
    property :entity_type
    property :title
    property :name
    property :address
    property :address2
    property :city
    property :state
    property :zip

    validates :entity_type, presence: true
  end

  property :address, populate_if_empty: Address do
    property :address

    validates :address, presence: true, length: { in: 3..512 }
  end

  collection :phones, populate_if_empty: Phone do
    model :phone

    # TODO: When Reform releases _destroy support implement that instead of this hack
    property :id, virtual: true
    property :_destroy, virtual: false

    property :number
    property :ext
    property :phone_type_id, type: Integer

    validates :number,
              presence: true,
              format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
              }

    validates :phone_type_id, presence: true
  end

  validate :phone_length

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
    validates :service_start_date, date: { on_or_before: DateTime.now }
    validates :service_end_date,
              date: { after: :service_start_date, on_or_before: DateTime.now },
              allow_blank: true,
              if: ->() { service_start_date }
  end

  # TODO: When Reform releases _destroy support implement that instead of this hack
  def save
    # you might want to wrap all this in a transaction
    super do |attrs|
      if model.persisted?
        to_be_removed = ->(i) { i[:_destroy] == '1' }
        ids_to_rm     = attrs[:phones].select(&to_be_removed).map { |i| i[:id] }

        Phone.destroy(ids_to_rm)
        phones.reject! { |i| ids_to_rm.include? i.id }
      end
    end

    # this time actually save
    super
  end

  private

  def phone_length
    remaining_phones = phones.reject { |i| i._destroy == '1' }
    errors.add :base, 'At most 3 phones' if remaining_phones.size > 3
    errors.add :base, 'At least 1 phone' if remaining_phones.size < 1
  end
end
