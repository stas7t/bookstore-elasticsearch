class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  validates :first_name, presence: true
  validates :first_name, :last_name, length: {
    maximum: 50,
    wrong_length: 'Invalid length',
    too_long: '%{count} characters is the maximum allowed'
  }
end
