# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  ORDER_FILTERS = { in_queue: 'Waiting for processing',
                    in_delivery: 'In delivery',
                    delivered: 'Delivered',
                    canceled: 'Canceled',
                    all: 'All' }.freeze

  def index
    order_status = params[:order_status]
    @orders = orders_by_status(order_status)

    @active_filter = order_status ? ORDER_FILTERS[order_status.to_sym] : 'All'
  end

  def show
    @order = current_user_orders.find(params[:id])
  end

  private

  def orders_by_status(order_status)
    case order_status
    when 'in_queue' then current_user_orders.in_queue
    when 'in_delivery' then current_user_orders.in_delivery
    when 'delivered' then current_user_orders.delivered
    when 'canceled' then current_user_orders.canceled
    else current_user_orders.placed
    end
  end

  def current_user_orders
    current_user.orders
  end
end
