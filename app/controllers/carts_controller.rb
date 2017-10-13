class CartsController < ApplicationController
  def show
    @order = Order.new(order_item_ids: session[:order_item_ids],
                       coupon_id: session[:coupon_id])
  end

  def update
    session[:coupon_id] = coupon.id if coupon

    redirect_to cart_path, notice: coupon ? 'Coupon applied' : 'Invalid coupon'
  end

  private

  def coupon
    @coupon ||= Coupon.find_by(active: true, code: params[:code])
  end
end
