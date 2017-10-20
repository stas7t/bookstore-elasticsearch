class AddressesController < ApplicationController
  def index
    @addresses = AddressesForm.new(user_id: current_user.id)
  end

  def update
    @addresses = AddressesForm.new(addresses_params)
    @addresses.save

    render :index
  end

  private

  def addresses_params
    params.require(:addresses_form)
  end
end
