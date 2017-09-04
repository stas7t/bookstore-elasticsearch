FactoryGirl.define do
  factory :author do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    description FFaker::Book.description
  end

  factory :author_invalid, parent: :author do
    first_name nil
  end
end
