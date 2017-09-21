class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  after_create :set_number, :set_status

  scope :in_progress, -> { where status: 'in_progress' }
  scope :in_queue,    -> { where status: 'in_queue'    }
  scope :in_delivery, -> { where status: 'in_delivery' }
  scope :delivered,   -> { where status: 'delivered'   }
  scope :canceled,    -> { where status: 'canceled'    }

  private

  def set_number
    update(number: "R#{id.to_s.rjust(8, '0')}")
  end

  def set_status
    update(status: 'in_progress')
  end
end
