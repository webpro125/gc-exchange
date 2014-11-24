module ProfileImage
  include Reform::Form::Module, RegexConstants

  property :profile_image

  validates :profile_image,
            file_size: { less_than: 1.megabytes },
            file_content_type: { allow: RegexConstants::ImageTypes::AS_IMAGES,
                                 message: I18n.t(
                                 'activerecord.errors.models.'\
                                 'consultant.attributes.upload.wrong_image_type') }
end
