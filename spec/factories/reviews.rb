FactoryGirl.define do
  factory :review do
    title "MyString"
    text "MyText"
    rating 1
    status %w[unprocessed approved rejected].sample
  end
end
