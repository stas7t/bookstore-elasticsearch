class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
  has_one :billing_address
  has_one :shipping_address
  has_one :delivery
  has_one :credit_card
  has_one :coupon

  after_create :set_number, :set_status

  scope :in_progress, -> { where status: 'in_progress' }
  scope :in_queue,    -> { where status: 'in_queue'    }
  scope :in_delivery, -> { where status: 'in_delivery' }
  scope :delivered,   -> { where status: 'delivered'   }
  scope :canceled,    -> { where status: 'canceled'    }

  include AASM

  aasm column: 'checkout_step' do
    state :address, initial: true
    state :delivery
    state :payment
    state :confirm
    state :complete

    event :next_step do
      transitions from: :address, to: :delivery
      transitions from: :delivery, to: :payment
      transitions from: :payment, to: :confirm
      transitions from: :confirm, to: :complete
    end
  end

  private

  def set_number
    update(number: "R#{id.to_s.rjust(8, '0')}")
  end

  def set_status
    update(status: 'in_progress')
  end
end
