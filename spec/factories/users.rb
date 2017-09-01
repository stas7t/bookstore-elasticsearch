FactoryGirl.define do
  factory :user do
    email FFaker::Internet.safe_email
    name 'Jon Snow'
    password 'test123XX'
  end
end
