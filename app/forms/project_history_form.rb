require 'reform/form/coercion'

class ProjectHistoryForm < Reform::Form
  model :project_history

  property :start_date, type: DateTime
  property :end_date, type: DateTime
  property :project_type_id
  property :position_ids
  property :description
  property :client_company
  property :client_poc_name
  property :client_poc_email
  property :customer_name_id

  validates :start_date, presence: true
  validates :project_type_id, presence: true
  validates :position_ids, presence: true
  validates :description, length: { in: 3..1_500 }, allow_blank: true
  validate :start_date_ok?
  validate :end_date_ok?
  validates :end_date, date: { on_or_after: :start_date }, allow_blank: true, if: ->() { start_date.present? }
  validates :client_company, length: { in: 3..512 }, presence: true
  validates :client_poc_name, length: { in: 2..256 }, presence: true,
            format: {  with: RegexConstants::Letters::AND_NUMBERS,
                       message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :client_poc_email, length: { in: 3..128 }, presence: true,
            format: { with: RegexConstants::EMAIL,
                      message: I18n.t('activerecord.errors.messages.regex.email') }

  property :phone, populate_if_empty: Phone do
    model :phone

    property :number
    property :ext
    property :phone_type_id, type: Integer

    validates :number,
              allow_blank: true,
              format:   {
                with:    RegexConstants::Phone::PHONE_NUMBER,
                message: I18n.t('activerecord.errors.messages.regex.phone')
              }

    validates :phone_type_id, presence: true, unless: ->() { number.empty? }
  end

  def start_date_ok?
    if start_date.respond_to?(:>) && start_date > DateTime.now
      errors.add(:start_date, "needs to be before today")
    end
  end

  def end_date_ok?
    if end_date.respond_to?(:>) && end_date > DateTime.now
      errors.add(:end_date, "needs to be before today")
    end
  end
end
