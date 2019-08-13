# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships, dependent: :destroy

  after_save :index_books_in_elasticsearch

  validates :first_name, presence: true
  validates :first_name, :last_name, length: {
    maximum: 50,
    wrong_length: 'Invalid length',
    too_long: '%{count} characters is the maximum allowed'
  }

  private

  def index_books_in_elasticsearch
    return unless Book.__elasticsearch__.index_exists? && books.any?

    books.find_each { |book| book.__elasticsearch__.index_document }
  end
end
