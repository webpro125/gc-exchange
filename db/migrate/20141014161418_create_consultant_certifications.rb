class CreateConsultantCertifications < ActiveRecord::Migration
  def change
    create_table :consultant_certifications do |t|
      t.references :consultant, index: true, null: false
      t.references :certification, index: true, null: false
    end

    add_index :consultant_certifications, [:consultant_id, :certification_id], unique: true,
              name: 'consultant_certifications_uniqueness'
  end
end
