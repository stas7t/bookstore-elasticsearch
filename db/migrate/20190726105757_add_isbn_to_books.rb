class AddIsbnToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :isbn, :string
  end
end
