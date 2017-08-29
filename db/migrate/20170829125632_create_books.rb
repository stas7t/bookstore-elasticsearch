class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.text :description
      t.decimal :height
      t.decimal :width
      t.decimal :depth
      t.integer :year_of_publication
      t.string :materials

      t.timestamps
    end
  end
end
