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

  def shipping_price
    return number_to_euro 0.00 unless current_order.delivery
    number_to_euro current_order.delivery.price
  end
end
