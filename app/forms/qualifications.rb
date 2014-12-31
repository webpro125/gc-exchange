module Qualifications
  include Reform::Form::Module

  property :skills_list
  property :certification_ids

  collection :educations, populate_if_empty: Education do
    property :degree_id
    property :field_of_study
    property :school

    validates :degree_id, presence: true
    validates :field_of_study, presence: true, length: { in: 2..256 }
    validates :school, presence: true, length: { in: 2..256 }
  end
end
