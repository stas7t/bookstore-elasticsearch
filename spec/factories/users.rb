FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@email.com" }
    name 'Jon Snow'
    password 'test123XX'
    # remote_avatar_url 'https://s3.eu-central-1.amazonaws.com/stas7t-bookstore/avatars/default_avatar_grey.png'
    after(:build) { |user| user.class.skip_callback(:save, :before) }
  end
end
