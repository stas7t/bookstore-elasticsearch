class AddBookRefToImages < ActiveRecord::Migration[5.1]
  def change
    add_reference :images, :book, foreign_key: true
  end
end
