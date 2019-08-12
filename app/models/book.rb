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

  settings index: { number_of_shards: 4 } do
    mapping dynamic: false do
      indexes :id, type: :integer

      indexes :title, type: 'text' do
        indexes :title
        indexes :raw, type: 'keyword'
      end

      indexes :description, type: :text
      indexes :isbn, type: :text
      indexes :price, type: :float
      indexes :publication_year, type: :integer
      indexes :created_at, type: :date
      indexes :sales, type: :integer
      indexes :cover_url, type: :text

      indexes :category, type: :object do
        indexes :id
        indexes :name
      end

      indexes :authors, type: :nested do
        indexes :id
        indexes :first_name
        indexes :last_name
      end
    end
  end

  def as_indexed_json(_options = nil) # rubocop:disable Metrics/MethodLength
    as_json(
      only: %i[
        id
        title
        description
        isbn
        publication_year
        price
        materials
        created_at
      ],
      methods: %i[cover_url sales],
      include: {
        authors: { only: %i[id first_name last_name] },
        category: { only: %i[id name] }
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
