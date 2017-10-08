class AddStatusToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :status, :integer, default: 0
  end
end
