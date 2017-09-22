class AddCheckoutStepToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :checkout_step, :string
  end
end
