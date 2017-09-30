class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[update destroy]

  def create
    @order_item = OrderItem.create(order_item_params)
    cart << @order_item.id

    redirect_back(fallback_location: root_path)
  end

  def update
    @order_item.update_attributes(order_item_params)
    @order_items = OrderItem.where(id: cart)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @order_item.destroy
    cart.delete_if { |item_id| item_id == @order_item.id }

    redirect_back(fallback_location: root_path)
  end

  private

  def cart
    session[:cart] ||= []
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
