module Resume
  include Reform::Form::Module

  RESUME_MIME_TYPES = ['application/msword', 'application/vnd.ms-word', 'application/pdf',
                       'applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document']

  property :resume

  validates :resume,
            presence: true,
            file_size: { less_than: 10.megabytes },
            file_content_type: { allow: RESUME_MIME_TYPES }
end
