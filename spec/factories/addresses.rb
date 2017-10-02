FactoryGirl.define do
  factory :address do
    type { %w[Billing Shipping].sample }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::Address.street_address.gsub(/[\W_]/, '') }
    city { FFaker::Address.city.gsub(/[\W_]/, '') }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::Address.country.gsub(/[\W_]/, '') }
    phone '+15555555555'
    user
    order
  end
end
