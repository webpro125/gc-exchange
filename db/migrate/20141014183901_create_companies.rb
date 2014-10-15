class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name, limit: 128
      t.references :owner, index: true

      t.timestamps
    end
  end
end
