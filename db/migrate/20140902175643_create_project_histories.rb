class CreateProjectHistories < ActiveRecord::Migration
  def change
    create_table :project_histories do |t|
      t.references :consultant, index: true, null: false
      t.string :customer_name, limit: 128
      t.string :client_company, limit: 128
      t.string :client_poc_name, limit: 64
      t.string :client_poc_email, limit: 128
      t.date :start_date
      t.date :end_date
      t.references :position, index: true, null: false
      t.text :description, limit: 10000

      t.timestamps
    end
  end
end
