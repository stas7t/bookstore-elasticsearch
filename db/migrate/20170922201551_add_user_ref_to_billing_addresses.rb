class AddUserRefToBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :billing_addresses, :user, foreign_key: true
  end
end
