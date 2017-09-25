class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  before_create :activate

  def activate
    self.active = true
  end
end
