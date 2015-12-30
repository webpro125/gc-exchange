class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.integer :entity_type
      t.string :title
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :consultant_id

      t.timestamps
    end

    Consultant.all.each do |consultant|
      Entity.create(entity_type: 'sole_proprietor', consultant: consultant)
    end
  end

end
