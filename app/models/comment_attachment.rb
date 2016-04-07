class CommentAttachment < ActiveRecord::Base
  mount_uploader :attach, CommentUploader, mount_on: :attach_file_name

  before_save :update_attach_attributes

  private

  def update_attach_attributes
    if attach.present? && attach_file_name_changed?
      self.attach_content_type = attach.file.content_type
      self.attach_file_size = attach.file.size
    end
  end
end
