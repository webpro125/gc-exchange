class ArticleAttachment < ActiveRecord::Base
  belongs_to :article

  mount_uploader :attach, ArticleUploader, mount_on: :attach_file_name

  before_save :update_attach_attributes

  validates :attach,
            file_size: { less_than: 10.megabytes }
            # file_content_type: { allow: RegexConstants::ImageTypes::AS_IMAGES }

  private

  def update_attach_attributes
    if attach.present? && attach_file_name_changed?
      self.attach_content_type = attach.file.content_type
      self.attach_file_size = attach.file.size
    end
  end
end
