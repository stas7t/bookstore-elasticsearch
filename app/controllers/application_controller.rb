class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  private
=begin
  def current_order
    @current_order ||= Order.find_or_initialize_by(id: order_id)
  end

  def order_id
    current_user ? current_user.orders.in_progress.last&.id : session[:order_id]
  end
=end

  def current_order
    current_order ||=
      if session[:order_id]
        Order.find(session[:order_id])
      elsif user_signed_in?
        user_orders = current_user.orders.in_progress
        user_orders.empty? ? Order.new : user_orders.last
      else
        Order.new
      end

    current_order
  end

  protected

  def after_sign_in_path_for(resource)
    if request.env['omniauth.origin']
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    else
      sign_in_url = new_user_session_url
      if request.referer == sign_in_url
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
end
