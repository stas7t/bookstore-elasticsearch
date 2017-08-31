class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :name, length: {
    minimum: 2,
    maximum: 50,
    wrong_length: 'Invalid length',
    too_long: "%{count} characters is the maximum allowed",
    too_short: "must have at least %{count} characters"
  }
end
