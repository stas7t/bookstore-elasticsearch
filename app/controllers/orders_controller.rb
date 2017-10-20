class OrdersController < ApplicationController
  before_action :authenticate_user!

  ORDER_FILTERS = { in_queue: 'Waiting for processing',
                    in_delivery: 'In delivery',
                    delivered: 'Delivered',
                    canceled: 'Canceled',
                    all: 'All' }.freeze

  def index
    order_status = params[:order_status]

    @orders = case order_status
              when 'in_queue' then current_user.orders.in_queue
              when 'in_delivery' then current_user.orders.in_delivery
              when 'delivered' then current_user.orders.delivered
              when 'canceled' then current_user.orders.canceled
              else current_user.orders.placed
              end

    @active_filter = order_status ? ORDER_FILTERS[order_status.to_sym] : 'All'
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
