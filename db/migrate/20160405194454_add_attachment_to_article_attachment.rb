class AddAttachmentToArticleAttachment < ActiveRecord::Migration
  def change
    change_table :article_attachments do |t|
      t.attachment :attach
    end
  end
end
