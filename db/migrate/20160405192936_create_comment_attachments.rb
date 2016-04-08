class CreateCommentAttachments < ActiveRecord::Migration
  def change
    create_table :comment_attachments do |t|
      t.references :comment, index: true
      t.timestamps
    end
  end
end
