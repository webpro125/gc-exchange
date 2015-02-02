class MakePhonesNullable < ActiveRecord::Migration
  def change
    change_column_null :phones, :phone_type_id, true
    change_column_null :phones, :number, true
  end
end
