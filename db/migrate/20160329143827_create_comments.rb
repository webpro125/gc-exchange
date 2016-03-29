class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :article, index: true, foreign_key: true
      t.references :commenter, index: true
      t.timestamps
    end
  end
end
