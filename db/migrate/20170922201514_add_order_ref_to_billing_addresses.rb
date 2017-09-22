class AddOrderRefToBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :billing_addresses, :order, foreign_key: true
  end
end
