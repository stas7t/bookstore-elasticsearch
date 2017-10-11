class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
  validates :height, :width, :depth, numericality: true

  paginates_per 12

  mount_uploader :cover, ImageUploader

  scope :by_category, ->(category_id) { where category_id: category_id }

  def sales
    orders.payed.map { |order| order.order_items.sum(:quantity) }.sum
  end

  def self.bestsellers(category_id = nil)
    best = Order.payed.joins(:order_items).group(:book_id)
                .order('sum("order_items"."quantity") DESC').count.keys
    Book.find(best)
  end
end
