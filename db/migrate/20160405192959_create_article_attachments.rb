class CreateArticleAttachments < ActiveRecord::Migration
  def change
    create_table :article_attachments do |t|
      t.references :article, index: true
      t.timestamps
    end
  end
end
