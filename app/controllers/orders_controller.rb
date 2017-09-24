class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
    redirect_to checkout_path(:confirm) if @order.status == 'in_progress'
  end
end