class AddOrderRefToShippingAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :shipping_addresses, :order, foreign_key: true
  end
end
