FactoryGirl.define do
  factory :book do
    title FFaker::Book.title
    price 9.99
    description FFaker::Book.description
    height 9.99
    width 9.99
    depth 9.99
    publication_year FFaker::Vehicle.year
    materials FFaker::Lorem.words.join(', ')
    authors []
    reviews []
  end
end
