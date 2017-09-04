FactoryGirl.define do
  factory :category do
    name "Category name"
  end

  factory :category_invalid do
    name nil
  end

  factory :category_updated do
    name "Updated category name"
  end
end
