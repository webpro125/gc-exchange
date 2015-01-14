require 'reform/form/coercion'

class EditConsultantForm < Reform::Form
  include Reform::Form::ModelReflections, Qualifications, OtherInformation

  model :consultant

  property :first_name
  property :last_name
  property :abstract

  validates :first_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :last_name, length: { in: 2..24 }, presence: true,
            format: { with: RegexConstants::Letters::AND_NUMBERS,
                      message: I18n.t('activerecord.errors.messages.regex.only_letters_numbers') }
  validates :abstract, length: { maximum: 1500 }

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end
end
