require 'reform/form/coercion'

class UploadImageForm < Reform::Form
  include ProfileImage

  model :consultant

  validates :profile_image, presence: true
end
