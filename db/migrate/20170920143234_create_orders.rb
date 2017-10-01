class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :number
      t.string :status
      t.references :user, foreign_key: true, index: true
      t.timestamp :completed_at
      t.timestamps
    end
  end
end
