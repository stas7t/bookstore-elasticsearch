class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :reviews

  validates :title, :quantity, :price, presence: true
  validates :title, uniqueness: true

  paginates_per 12
end
