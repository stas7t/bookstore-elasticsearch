class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    @order = current_order
    #@billing_address = @order.build_billing_address
    #@shipping_address = @order.build_shipping_address
    case step
    when :login
      skip_step if current_user
    when :address
      @form_b = AddressForm.new()
      @form_s = AddressForm.new()
      #@form = AddressForm.new(current_order)
      #render 'checkout/address'
      #return
      #@form = AddressForm.new(@order)
      #@b_address = @user.billing_address
      #@s_address = @user.shipping_address
    end
    render_wizard
  end

  def update
    @form_b = AddressForm.new(b_params)
    @form_s = AddressForm.new(s_params)
    @user = current_user
    @order = current_order
    #@billing_address = @order.build_billing_address
    #@shipping_address = @order.build_shipping_address
    #@billing_address.update_attributes!(ba_params)
    #@shipping_address.update_attributes(sa_params)
    render_wizard @form_b && @form_s
  end

  def b_params
    params.require(:address).permit(billind_address_attributes: [:first_name, :last_name, :address, :city, :country, :zip, :phone])
  end

  def s_params
    params.require(:address).permit(shipping_address_attributes: [:first_name, :last_name, :address, :city, :country, :zip, :phone])
  end
end


