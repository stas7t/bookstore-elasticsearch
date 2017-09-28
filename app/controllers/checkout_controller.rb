class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :login, :addresses, :delivery, :payment, :confirm, :complete

  before_action :assign_order_to_user

  def show
    # return redirect_to catalog_path if no_items_in_cart?
    # send("show_#{step}") unless step == 'wicked_finish'
    case step
    when :login     then login
    when :addresses then show_addresses
    when :delivery  then show_delivery
    when :payment   then show_payment
    when :confirm   then show_confirm
    when :complete  then show_complete
    end
    render_wizard
  end

  def update
    case step
    when :addresses then update_addresses
    when :delivery  then update_delivery
    when :payment   then update_payment
    when :confirm   then update_confirm
    when :complete  then update_complete
    end
    redirect_to next_wizard_path unless performed?
  end

  private

  def assign_order_to_user
    current_order.update_attributes(user_id: current_user.id) if current_order.user_id.nil?
  end

  # show
  def login
    return jump_to(next_step) if user_signed_in?
    cookies[:from_checkout] = { value: true, expires: 1.day.from_now }
  end

  def show_addresses
    @addresses = AddressesForm.new(show_addresses_params)
  end

  def show_delivery
    return jump_to(previous_step) unless current_order.addresses.presence
    @deliveries = Delivery.all
  end

  def show_payment
    return jump_to(previous_step) unless current_order.delivery
    @credit_card = current_order.credit_card || current_user.credit_card || CreditCard.new
  end

  def show_confirm
    return jump_to(previous_step) unless current_order.credit_card
    show_addresses
  end

  def show_complete
    return jump_to(previous_step) unless flash[:complete_order]
    @order = current_user.orders.in_queue.last#.processing_order.decorate
  end

  # update
  def update_addresses
    @addresses = AddressesForm.new(addresses_params)
    render_wizard unless @addresses.save
  end

  def update_delivery
    current_order.update_attributes(order_params)
    flash[:notice] = 'Please choose delivery mehod.' if current_order.delivery_id.nil?
  end

  def update_payment
    @credit_card = CreditCard.new(credit_card_params)
    render_wizard unless @credit_card.save
    current_order.update_attributes(credit_card_id: @credit_card.id)
  end

  def update_confirm
    flash[:complete_order] = true
    current_order.update_attributes(user_id: current_user.id)
    current_order.place_in_queue
    session[:order_id] = nil if current_order.status == 'in_queue'
  end

  # params
  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :name_on_card, :month_year, :cvv)
  end

  def addresses_params
    params.require(:addresses_form)
  end

  def show_addresses_params
    return { user_id: current_user.id } if current_order.addresses.empty?
    { order_id: current_order.id }
  end
end
