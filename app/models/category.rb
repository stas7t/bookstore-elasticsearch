class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {
    maximum: 50,
    wrong_length: 'Invalid length',
    too_long: '%{count} characters is the maximum allowed'
  }
end
