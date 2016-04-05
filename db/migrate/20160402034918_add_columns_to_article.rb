class AddColumnsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :status, :integer, default: 0
    add_reference :articles, :admin, index: true
    add_column :articles, :views, :integer, default: 0
    add_reference :comments, :admin_commenter, index: true
  end
end
