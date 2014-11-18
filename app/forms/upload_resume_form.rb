require 'reform/form/coercion'

class UploadResumeForm < Reform::Form
  include Resume

  model :consultant
end
