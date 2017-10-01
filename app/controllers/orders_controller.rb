class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
                          .where.not(status: 'in_progress')
                          .order('created_at desc')
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
