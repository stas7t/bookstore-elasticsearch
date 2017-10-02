FactoryGirl.define do
  factory :order_item do
    transient do
      book
    end
    quantity 1
  end
end
