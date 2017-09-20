class AddBookRefToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :book, foreign_key: true
  end
end
