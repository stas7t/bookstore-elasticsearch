# frozen_string_literal: true

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

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(_options = {})
    as_json(
      only: %i[id title description publication_year price materials],
      include: {
        authors: { only: %i[first_name last_name] },
        category: { only: %i[name] }
      }
    )
  end

  def sales
    orders.payed.map { |order| order.order_items.sum(:quantity) }.sum
  end

  def self.best_sellers
    best = Order.payed.joins(:order_items).group(:book_id)
                .order('sum("order_items"."quantity") DESC').count.keys
    Book.find(best)
  end
end

Book.import
