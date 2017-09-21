class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  private

  #def current_order
  #  return Order.find(session[:order_id]) unless session[:order_id].nil?
  #  # return current_user.last_uncompleted_order if current_user&.last_uncompleted_order
  #  order = Order.create
  #  session[:order_id] = order.id
  #  order
  #end

  def current_order
    return current_user.orders.in_progress.last || Order.new if user_signed_in?

    if session[:order_id].nil?
      Order.new
    else
      Order.find(session[:order_id]) || Order.new
    end
  end
end
