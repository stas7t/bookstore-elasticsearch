class Checkout::AddressController < ApplicationController
  def edit
    @form = AddressForm.new(a_params)
  end

  def update
    @form = AddressForm.new(a_params)
    next_step if @form.valid?
    # return working_with_object if @form.valid?
    # render :edit
  end

  # private

  def working_with_object
    return render :edit unless @form.validate(params[controller_name.to_sym])
    @form.save
    # checkout_flow
    # redirect_to send("checkout_#{current_order.aasm.current_state}_path"), notice: 'Success!'
  end

  def checkout_flow
    current_order.next_step! unless current_order.confirm? || current_order.complete?
  end

  def same_address
    current_order.use_same_address
  end


  def a_params
    params.require(:address_form).permit(:first_name, :last_name, :address, :city, :country, :zip, :phone, :user_id, :order_id)
  end
end
