class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: { only_integer: true,
                                                       greater_than: 0 }

  def total
    book.price * quantity
  end
end
