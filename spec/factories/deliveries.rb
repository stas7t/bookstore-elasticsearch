FactoryGirl.define do
  factory :delivery do
    sequence(:name) { |i| "Delivery#{i}" }
    time '1 to 2 days'
    price 9.99
  end
end
