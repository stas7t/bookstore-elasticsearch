FactoryGirl.define do
  factory :review do
    transient do
      status 'approved'
    end

    rating 5
    sequence(:title) { |i| "Review title #{i}" }
    sequence(:text) { |i| "Review text #{i}" }
    association :book
    association :user

    before(:create) do |review, evaluator|
      review.status = evaluator.status
    end
  end
end
