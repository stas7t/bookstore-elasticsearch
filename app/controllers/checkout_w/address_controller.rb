class CheckoutW::AddressController < ApplicationController
  def edit

  end

  def update

    return next_step if @form.valid?
    render :edit
  end
end
