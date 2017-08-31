class AddStatusToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :status, :string, default: 'unprocessed'
  end
end
