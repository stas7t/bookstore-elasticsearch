class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    return redirect_to catalog_path if no_items_in_cart?
    send("show_#{step}") unless step == 'wicked_finish'
    render_wizard
  end

  def update
    send("update_#{step}")
    redirect_to next_wizard_path unless performed?
  end

  private

  def no_items_in_cart?
    current_order.order_items.empty? && step != :complete
  end

  # show
  def show_login
    return jump_to(next_step) if user_signed_in?
    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def show_address
    @addresses = AddressesForm.new(show_addresses_params)
  end

  def show_delivery
    return jump_to(previous_step) unless current_order.addresses.presence
    @deliveries = Delivery.all
  end

  def show_payment
    return jump_to(previous_step) unless current_order.delivery
    @credit_card = current_order.credit_card || CreditCard.new
  end

  def show_confirm
    return jump_to(previous_step) unless current_order.credit_card
    show_addresses
  end

  def show_complete
    return jump_to(previous_step) unless flash[:complete_order]
    @order = current_user.orders.processing_order.decorate
  end

  def fast_authentification!
    return unless user_signed_in? && step != :login
    jump_to(:login) unless user_signed_in?
  end

  def show_addresses_params # take data from settings if persist
    return { user_id: current_user.id } if current_order.addresses.empty?
    { order_id: current_order.id }
  end

  # update
  def update_address
    @addresses = AddressesForm.new(addresses_params)
    render_wizard unless @addresses.save
  end

  def update_delivery
    current_order.update_attributes(order_params)
    flash[:notice] = t('delivery.pickup') if current_order.delivery_id.nil?
  end

  def update_payment
    @credit_card = CreditCard.new(credit_card_params)
    render_wizard unless @credit_card.save
  end

  def update_confirm
    flash[:complete_order] = true
    session[:order_id] = nil if current_order.finalize
  end

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :name, :mm_yy, :cvv)
  end

  def addresses_params
    params.require(:addresses_form)
  end
end


