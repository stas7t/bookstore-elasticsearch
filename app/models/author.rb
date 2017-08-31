class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :first_name, presence: true
  validates :first_name, :last_name, length: {
    maximum: 50,
    wrong_length: 'Invalid length',
    too_long: "%{count} characters is the maximum allowed"
  }
end
