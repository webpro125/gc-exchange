class CreateConsultantSkills < ActiveRecord::Migration
  def change
    create_table :consultant_skills do |t|
      t.references :consultant, index: true, null: false
      t.references :skill, index: true, null: false

      t.timestamps
    end
  end
end
