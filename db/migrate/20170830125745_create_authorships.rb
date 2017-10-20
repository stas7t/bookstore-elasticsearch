class CreateAuthorships < ActiveRecord::Migration[5.1]
  def change
    create_table :authorships, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :book, index: true
    end
    add_index :authorships, [:author_id, :book_id]
  end
end
