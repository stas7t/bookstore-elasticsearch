class AddressesForm
  include ActiveModel::Model
  # include ActiveModel::Validations
  include Virtus.model

  # Attributes (DSL provided by Virtus)
  attribute :first_name, String
  attribute :last_name,  String
  attribute :address,    String
  attribute :city,       String
  attribute :country,    String
  attribute :zip,        String
  attribute :phone,      String

  # Access the expense record after it's saved
  attr_reader :params, :relation, :use_billing

  # Validations


  # GGGG
  def initialize(params = false)
    @save = false
    @params = params
    @relation = Order.find_by(id: order_id) || User.find_by(id: user_id) || User.new
  end

  def save
    @save = true
    return false unless valid?
    persist!
    true
  end

  def errors
    { billing: billing.errors, shipping: shipping.errors }
  end

  def billing
    new_billing = relation.addresses.find_or_initialize_by(type: 'Billing')
    new_billing.assign_attributes(params_for(:billing)) if save?
    @billing ||= new_billing
  end

  def shipping
    new_shipping = relation.addresses.find_or_initialize_by(type: 'Shipping')
    new_shipping.assign_attributes(params_for(:shipping)) if save?
    @shipping ||= new_shipping
  end

  private

  def user_id
    params.fetch(:user_id, false) || (params[:billing][:user_id] if nested?)
  end

  def order_id
    params.fetch(:order_id, false) || (params[:billing][:order_id] if nested?)
  end

  def nested?
    params.fetch(:billing, false)
  end

  def save?
    @save
  end

  def persist!
    billing.save
    shipping.save
  end

  def valid?
    billing.valid?
    shipping.valid?
  end

  def params_for(type)
    type = params[:use_billing] == '1' ? :billing : type
    params.require(type).permit(:first_name, :last_name, :address,
                                :country, :city, :zip, :phone,
                                :user_id, :order_id)
  end
end
