class AddressesController < ApplicationController
  def index
    @addresses = AddressesForm.new(user_id: current_user.id)
  end

  def create
    @addresses = AddressesForm.new(addresses_params)
    status = @addresses.save ? :created : :found
    render :index, object: @addresses.errors
  end

  private

  def addresses_params
    params.require(:addresses_form)
  end
end