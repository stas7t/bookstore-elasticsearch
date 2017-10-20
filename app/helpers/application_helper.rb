module ApplicationHelper
  def categories
    Category.order('name')
  end

  def cart_items_count
    return OrderItem.where(id: session[:order_item_ids]).sum(:quantity) if session[:order_item_ids]
    current_order.order_items.sum(:quantity)
  end

  def number_to_euro(amount)
    number_to_currency(amount, unit: '€')
  end
end
