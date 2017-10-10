class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :first_name, :last_name, :city, :country,
            presence: true,
            format: { with: /\A[a-zA-Z]*\z/,
                      message: 'Consist of a-z, A-Z only, no special symbols' },
            length: { maximum: 50 }

  validates :address,
            presence: true,
            format: { with: /\A[a-zA-Z0-9 \-\,]*\z/,
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

  scope :shipping, -> { where(type: 'Shipping') }
  scope :billing, -> { where(type: 'Billing') }

  def country_name
    country_full = ISO3166::Country[country]
    country_full.translations[I18n.locale.to_s] || country_full.name
  end
end
