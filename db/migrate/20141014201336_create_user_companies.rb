class CreateUserCompanies < ActiveRecord::Migration
  def change
    create_table :user_companies do |t|
      t.references :user, index: true
      t.references :company, index: true

      t.timestamps
    end
  end
end
