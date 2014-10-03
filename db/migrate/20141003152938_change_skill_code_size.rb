class ChangeSkillCodeSize < ActiveRecord::Migration
  def up
    change_column :skills, :code, :string, null: false, limit: 128
  end

  def down
    change_column :skills, :code, :string, null: false, limit: 32
  end
end
