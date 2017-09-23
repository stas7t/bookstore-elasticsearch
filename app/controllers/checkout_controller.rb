class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    @order = current_order
    @billing_address = @order.build_billing_address
    @shipping_address = @order.build_shipping_address
    case step
    when :login
      skip_step if current_user
    when :address
      #@form = AddressForm.new(current_order)
      #render 'checkout/address'
      #return
      @form = AddressForm.new(@order)
      #@b_address = @user.billing_address
      #@s_address = @user.shipping_address
    end
    render_wizard
  end

  def update
    #@form = AddressForm.new(@order)
    @user = current_user
    @order = current_order
    @billing_address = @order.build_billing_address
    @shipping_address = @order.build_shipping_address
    @billing_address.update_attributes!(ba_params)
    #@shipping_address.update_attributes(sa_params)
    render_wizard @billing_address && @shipping_address
  end

  def ba_params
    params.require(:address).permit(billind_address_attributes: [:first_name, :last_name, :address, :city, :country, :zip, :phone])
  end

  def sa_params
    params.require(:address).permit(shipping_address_attributes: [:first_name, :last_name, :address, :city, :country, :zip, :phone])
  end
end


