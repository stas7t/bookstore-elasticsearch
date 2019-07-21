# frozen_string_literal: true

module CheckoutHelper
  def step_state(current_step)
    return 'active' if step_active?(current_step)
    'done' if step_done?(current_step)
  end

  def step_active?(current_step)
    current_step == step
  end

  def step_done?(current_step)
    past_step?(current_step)
  end

  def coupon_discount(order)
    return number_to_euro 0.00 unless order.coupon
    "- #{number_to_euro order.coupon.discount}"
  end

  def shipping_price(order)
    return number_to_euro 0.00 unless order.delivery
    number_to_euro order.delivery.price
  end
end
