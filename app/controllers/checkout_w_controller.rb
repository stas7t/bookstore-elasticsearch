class CheckoutWController < ApplicationController
  include Wicked::Wizard

  steps :login, :address, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    case step
    when :login
      skip_step if current_user
    when :address
      #@b_address = @user.billing_address
      #@s_address = @user.shipping_address
    end
    render_wizard
  end
end
