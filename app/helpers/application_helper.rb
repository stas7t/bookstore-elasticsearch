module ApplicationHelper
  def categories
    Category.order('name')
  end

  def cart_items_count
    return OrderItem.where(id: session[:cart]).sum(:quantity) if session[:cart]
    current_order.order_items.sum(:quantity)
  end

  def number_to_euro(amount)
    number_to_currency(amount, unit: '€')
  end
end
