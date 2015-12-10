class AddFdicToCustomerName < ActiveRecord::Migration
  def change
    CustomerName.create(code: "FDIC", label: "Federal Deposit Insurance Corporation")
  end
end
