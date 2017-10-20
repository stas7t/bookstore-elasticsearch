class AddCreditCardRefToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :credit_card, foreign_key: true
  end
end
