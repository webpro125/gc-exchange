class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :consultant, index: true, null: false
      t.references :degree, index: true, null: false
      t.string :school, limit: 256
      t.string :field_of_study, limit: 256

      t.timestamps
    end
  end
end
