class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, limit: 128
      t.text :text, limit: 500
      t.references :user
      t.timestamps
    end
  end
end
