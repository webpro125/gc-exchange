class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :code, limit: 32, null: false
    end
    add_index :certifications, :code, unique: true
  end
end
