class Coupon < ApplicationRecord
  belongs_to :order, optional: true

  before_create :activate
  
  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: true

  def activate
    self.active = true
  end
end
