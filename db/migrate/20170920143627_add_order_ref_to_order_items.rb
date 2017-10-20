class AddOrderRefToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :order, foreign_key: true
  end
end
