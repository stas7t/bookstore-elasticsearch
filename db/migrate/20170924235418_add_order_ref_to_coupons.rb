class AddOrderRefToCoupons < ActiveRecord::Migration[5.1]
  def change
    add_reference :coupons, :order, foreign_key: true
  end
end
