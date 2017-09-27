class AddColumnTotalToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :total, :decimal
  end
end
