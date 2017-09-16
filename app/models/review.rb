class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, :text, :rating, presence: true
  validates :status, inclusion: { in: %w[unprocessed approved rejected] }
  validates :rating, numericality: { only_integer: true,
                                     greater_than: 0,
                                     less_than_or_equal_to: 5 }
  validates :title, length: {
    minimum: 1,
    maximum: 80,
    wrong_length: 'Invalid length',
    too_long: "%{count} characters is the maximum allowed",
    too_short: "must have at least %{count} characters"
  }
  validates :text, length: {
    minimum: 1,
    maximum: 500,
    wrong_length: 'Invalid length',
    too_long: "%{count} characters is the maximum allowed",
    too_short: "must have at least %{count} characters"
  }
  validates :title, :text,
            format: { with: %r/\A[a-zA-Z0-9 \n\r!#$%&'*+-\/=?^_`{|}~]*\z/,
                      message: "must consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~" }

  scope :unprocessed, -> { where status: 'unprocessed' }
  scope :processed, -> { where status: 'approved' || 'rejected' }
end
