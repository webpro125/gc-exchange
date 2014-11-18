module ProfileImage
  include Reform::Form::Module, RegexConstants

  property :profile_image

  validates :profile_image,
            file_size: { less_than: 1.megabytes },
            file_content_type: { allow: RegexConstants::ImageTypes::AS_IMAGES }
end
