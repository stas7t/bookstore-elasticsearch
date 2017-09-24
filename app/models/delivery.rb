class Delivery < ApplicationRecord
  has_many :orders
  validates :name, :time, :price, presence: true
end
