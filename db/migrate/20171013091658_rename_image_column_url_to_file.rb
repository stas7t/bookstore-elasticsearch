class RenameImageColumnUrlToFile < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :url, :file
  end
end
