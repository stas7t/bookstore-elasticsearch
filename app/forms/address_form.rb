class AddressForm
  include ActiveModel::Model
  include Virtus

  # Attributes (DSL provided by Virtus)
  attribute :first_name, String
  attribute :last_name,  String
  attribute :address,    String
  attribute :city,       String
  attribute :country,    String
  attribute :zip,        String
  attribute :phone,      String

  # Access the expense record after it's saved
  attr_reader :address

  # Validations
  validates :first_name, :last_name, :city, :country,
            presence: true,
            format: { with: /\A[a-zA-Z]*\z/,
                      message: 'Consist of a-z, A-Z only, no special symbols' },
            length: { maximum: 50 }

  validates :address,
            presence: true,
            format: { with: /\A[a-zA-Z \-\,]*\z/,
                      message: 'Consist of a-z, A-Z, 0-9,’,’, ‘-’, ‘ ’ only, no special symbols' },
            length: { maximum: 50 }

  validates :zip,
            presence: true,
            format: { with: /\A[0-9\-]*\z/,
                      message: 'Consist of 0-9 only,’-’ no special symbols' },
            length: { maximum: 10 }

  validates :phone,
            presence: true,
            format: { with: /\A\+[0-9]*\z/,
                      message: 'Consist of 0-9 only no special symbols' },
            length: { maximum: 15 }

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    #user = User.create!(email: email)
    user = current_user
    order = current_order
    @address = current_order.billing_address.create!(first_name: first_name,
                                                    last_name: last_name,
                                                    address: address,
                                                    city: city,
                                                    country: country,
                                                    zip: zip,
                                                    phone: phone,
                                                    user_id: user.id)
  end


=begin
class AddressForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name,  String
  attribute :address,    String
  attribute :city,       String
  attribute :country,    String
  attribute :zip,        String
  attribute :phone,      String

  validates :first_name, :last_name, :city, :country,
            presence: true,
            format: { with: /\A[a-zA-Z]*\z/,
                      message: 'Consist of a-z, A-Z only, no special symbols' },
            length: { maximum: 50 }

  validates :address,
            presence: true,
            format: { with: /\A[a-zA-Z \-\,]*\z/,
                      message: 'Consist of a-z, A-Z, 0-9,’,’, ‘-’, ‘ ’ only, no special symbols' },
            length: { maximum: 50 }

  validates :zip,
            presence: true,
            format: { with: /\A[0-9\-]*\z/,
                      message: 'Consist of 0-9 only,’-’ no special symbols' },
            length: { maximum: 10 }

  validates :phone,
            presence: true,
            format: { with: /\A\+[0-9]*\z/,
                      message: 'Consist of 0-9 only no special symbols' },
            length: { maximum: 15 }
=end
end
