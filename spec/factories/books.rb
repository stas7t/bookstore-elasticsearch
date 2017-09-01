FactoryGirl.define do
  factory :book do
    title FFaker::Book.title
    price [5.99, 10.99, 19.99, 29.99].sample
    quantity 1
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
