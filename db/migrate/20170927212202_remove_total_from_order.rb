class RemoveTotalFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :total, :decimal
  end
end
