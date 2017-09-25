class AddOrderRefToCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :credit_cards, :order, foreign_key: true
  end
end
