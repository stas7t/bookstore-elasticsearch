class RemoveImagesFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :images, :json
  end
end
