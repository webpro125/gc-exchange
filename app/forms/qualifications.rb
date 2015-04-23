module Qualifications
  include Reform::Form::Module

  property :skills_list
  property :certification_ids

  collection :educations, populate_if_empty: Education do
    # TODO: When Reform releases _destroy support implement that instead of this hack
    property :id, virtual: false
    property :_destroy, virtual: false

    property :degree_id
    property :field_of_study
    property :school

    validates :degree_id, presence: true
    validates :field_of_study, presence: true, length: { in: 2..256 }
    validates :school, presence: true, length: { in: 2..256 }
  end

  validate :education_length
  validate :skills_length
  validate :certifications_length

  # TODO: When Reform releases _destroy support implement that instead of this hack
  def save
    # you might want to wrap all this in a transaction
    super do |attrs|
      if model.persisted?
        to_be_removed = ->(i) { i[:_destroy] == '1' }
        ids_to_rm = attrs[:educations].select(&to_be_removed).map { |i| i[:id] }

        Education.destroy(ids_to_rm)
        educations.reject! { |i| ids_to_rm.include? i.id }
      end
    end

    # this time actually save
    super
  end

  private

  def education_length
    remaining_educations = educations.reject { |i| i._destroy == '1' }
    errors.add :base, 'At most 3 educations' if remaining_educations.size > 3
  end

  def skills_length
    remaining_skills = skills_list.split(',')
    errors.add :base, 'At most 40 skills' if remaining_skills.size > 40
  end

  def certifications_length
    errors.add :base, 'At most 10 certifications' if certification_ids.size > 10
  end
end
