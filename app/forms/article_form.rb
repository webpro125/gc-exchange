require 'reform/form/coercion'

class ArticleForm < Reform::Form

  model :article

  property :title
  property :text

  validates :title,
            presence:   true,
            length:     { in: 2..36 },
            uniqueness: { case_sensitive: true }
  validates :text, presence: true, length: { in: 2..500 }

  collection :article_attachments, populate_if_empty: ArticleAttachment do
    model :article_attachment

    property :attach

    validates :attach,
              presence: true,
              file_size: { less_than: 10.megabytes },
              file_content_type: { allow: RegexConstants::ImageTypes::AS_IMAGES }
  end
end
