class OrderItemsController < ApplicationController
  before_action :set_current_order

  def create
    @order_item = OrderItem.new(order_item_params)

    save_order if @order.id.nil?
    @order_item.order_id = @order.id
    @order_item.save!

    redirect_back(fallback_location: root_path)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def set_current_order
    @order = current_order
  end

  def save_order
    @order.status = 'in_progress'
    @order.save
    session[:order_id] = @order.id
  end
end
