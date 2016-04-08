class AddAttachmentToCommentAttachment < ActiveRecord::Migration
  def change
    change_table :comment_attachments do |t|
      t.attachment :attach
    end
  end
end
