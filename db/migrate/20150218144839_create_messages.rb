class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject, limit: 128, null: false
      t.text :message, limit: 5000, null: false

      t.timestamps
    end
  end
end
