class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true,
                                                       greater_than: 0 }
end
