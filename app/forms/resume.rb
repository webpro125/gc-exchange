module Resume
  include Reform::Form::Module, RegexConstants

  property :resume

  validates :resume,
            presence: true,
            file_size: { less_than: 10.megabytes },
            file_content_type: { allow: RegexConstants::FileTypes::AS_DOCUMENTS,
                                 message: I18n.t(
                                 'activerecord.errors.models.'\
                                 'consultant.attributes.upload.wrong_document_type') }
end
