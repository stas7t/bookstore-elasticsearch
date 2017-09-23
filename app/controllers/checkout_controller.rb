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
      @form = AddressForm.from_params(params)
      #@b_address = @user.billing_address
      #@s_address = @user.shipping_address
    end
    render_wizard
  end
end
