class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  private

  def current_order(complete_checkout = nil)
    c_order ||=
      if session[:order_id]
        Order.find(session[:order_id])
      elsif user_signed_in? && current_user.orders.find_by(status: 'in_progress').present?
        current_user.orders.find_by(status: 'in_progress')
        #user_orders = current_user.orders.in_progress
        #user_orders.empty? ? Order.new : user_orders.last
      else
        Order.new
      end
    return nil if complete_checkout == 'complete'
    c_order
  end

  protected

  def after_sign_in_path_for(resource)
    if cookies[:from_checkout]
      cookies.delete :from_checkout
      checkout_path(:addresses)
    else
      super
    end
  end
end
