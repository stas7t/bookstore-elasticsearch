FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@email.com" }
    name 'Jon Snow'
    password 'test123XX'
    after(:build) { |user| user.class.skip_callback(:save, :before) }
  end
end
