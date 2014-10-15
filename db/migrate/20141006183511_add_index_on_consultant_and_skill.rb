class AddIndexOnConsultantAndSkill < ActiveRecord::Migration
  def change
  end
  add_index :consultant_skills, [:consultant_id, :skill_id], unique: true
end
