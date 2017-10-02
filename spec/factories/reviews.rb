FactoryGirl.define do
  factory :review do
    transient do
      status 'approved'
    end

    rating 5
    title 'Review title'
    text 'Review text'
    association :book
    association :user

    before(:create) do |review, evaluator|
      review.status = evaluator.status
    end
  end
end
