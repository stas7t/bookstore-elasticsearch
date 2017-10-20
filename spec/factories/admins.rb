FactoryGirl.define do
  factory :admin do
    sequence(:email) { |i| "admin#{i}@email.com" }
    password 'test123XX'
  end
end
