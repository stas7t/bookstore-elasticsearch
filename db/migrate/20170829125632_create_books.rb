class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :publication_year
      t.decimal :price,  precision: 5, scale: 2
      t.decimal :height, precision: 4, scale: 2
      t.decimal :width,  precision: 4, scale: 2
      t.decimal :depth,  precision: 4, scale: 2
      t.string :materials

      t.timestamps
    end
  end
end
