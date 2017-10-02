FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@email.com" }
    name 'Jon Snow'
    password 'test123XX'
  end
end
