class CreditCard < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders

  validates :number, :name_on_card, :month_year, :cvv, presence: true

  #validates :title, :text,
  #          format: { with: %r/\A[a-zA-Z0-9 \n\r!#$%&'*+-\/=?^_`{|}~]*\z/,
  #                    message: "must consist of a-z, A-Z, 0-9, or one of !#$%&'*+-/=?^_`{|}~" }

  #validates :number, :name_on_card, :mm, :yy, :cvv, presence: true
  #validates_length_of :number, is: 16
  #validates_length_of :cvv, in: 3..4
  #validates :cvv, numericality: { only_integer: true }
  #validates_format_of :mm_yy, with: %r{\A(0[1-9]|10|11|12)\/\d\d\z}, message: I18n.t('validation.mm_yy')
  #validates_format_of :number, with: %r{\A\d{16}\z}, message: 'validation.cart_number'
  #validates_format_of :name_on_card, with: %r{\A[a-zA-Z\s]{0,49}\z}, message: 'validation.cart_name'
end
