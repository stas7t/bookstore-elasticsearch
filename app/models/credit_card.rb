class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy

  validates :number, :name_on_card, :month_year, :cvv, presence: true

  validates :name_on_card, length: { maximum: 50 }
  validates :number, length: { is: 16 }
  validates :cvv, length: 3..4
  validates :number, :cvv, numericality: { only_integer: true }

  validates :name_on_card, format: /\A[a-zA-Z]*\s*[a-zA-Z]*\z/
  validates :month_year, format: /\A(0[1-9]|10|11|12)\/\d\d\z/
end
