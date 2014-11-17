module ProfileImage
  include Reform::Form::Module

  property :profile_image

  validates :profile_image,
            file_size: { less_than: 1.megabytes },
            file_content_type: { allow: ['image/jpg',
                                         'image/png',
                                         'image/jpeg'] }
end
