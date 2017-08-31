class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :text, length: {
    minimum: 2,
    maximum: 80,
    wrong_length: 'Invalid length',
    too_long: "%{count} characters is the maximum allowed",
    too_short: "must have at least %{count} characters"
  }
  validates :title, :text,
            format: { with: %r/\A[a-zA-Z0-9 &-\/]*\z/,
                      message: "must consist of a-z, A-Z, 0-9, or one of &-/" }
end
