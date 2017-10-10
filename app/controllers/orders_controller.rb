class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.placed
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
