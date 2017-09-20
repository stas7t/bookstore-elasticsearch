class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships
  has_many :authors, through: :authorships
  has_many :reviews

  validates :title, :price, presence: true
  validates :title, uniqueness: true

  paginates_per 12

  scope :by_category, ->(category_id) { where category_id: category_id }
end
