require 'reform/form/coercion'

class UploadImageConsultantForm < Reform::Form
  include Reform::Form::ModelReflections

  model :consultant

  property :profile_image
  property :profile_image_file_name
  # property :profile_image_file_type
  validates :profile_image,
            file_size: { less_than: 1.megabytes },
            file_content_type: { allow: ['image/jpg',
                                         'image/png',
                                         'image/jpeg'] }

  def self.reflect_on_association(association)
    Consultant.reflect_on_association(association)
  end

  def new_record?
    @model.new_record?
  end
end
