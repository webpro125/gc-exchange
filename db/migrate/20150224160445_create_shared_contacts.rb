class CreateSharedContacts < ActiveRecord::Migration
  def change
    create_table :shared_contacts do |t|
      t.references :consultant, index: true, null: false
      t.references :user, index: true, null: false
      t.boolean :allowed, null: false, default: false

      t.timestamps
    end
  end
end
