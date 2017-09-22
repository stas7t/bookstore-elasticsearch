class AddUserRefToShippingAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :shipping_addresses, :user, foreign_key: true
  end
end
