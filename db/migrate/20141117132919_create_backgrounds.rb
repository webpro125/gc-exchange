class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.references :consultant, index: true
      t.boolean :citizen, null: false
      t.boolean :convicted, null: false
      t.boolean :parole, null: false
      t.boolean :illegal_drug_use, null: false
      t.boolean :illegal_purchase, null: false
      t.boolean :illegal_prescription, null: false

      t.timestamps
    end
  end
end
