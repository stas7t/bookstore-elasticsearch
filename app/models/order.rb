class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  after_create :set_number

  private

  def set_number
    update(number: "R#{id.to_s.rjust(8, '0')}")
  end
end
