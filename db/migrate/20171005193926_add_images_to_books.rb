class AddImagesToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :images, :json
  end
end
