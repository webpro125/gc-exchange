class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name, limit: 512
      t.references :owner, index: true, unique: true

      t.timestamps
    end
  end
end
