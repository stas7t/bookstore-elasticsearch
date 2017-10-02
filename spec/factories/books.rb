FactoryGirl.define do
  factory :book do
    transient do
      cost 99.99
      category_name { FactoryGirl.create(:category).id }
    end

    price 1.0
    sequence(:title) { |i| FFaker::Book.title + i.to_s }
    description FFaker::Book.description
    publication_year 2015
    height 1.1
    width 2.0
    depth 0.8
    materials 'paper, silk'
    category

    before(:create) do |book, evaluator|
      book.category_id = (Category.find_by(name: evaluator.category_name) ||
        FactoryGirl.create(:category, name: evaluator.category_name)).id
    end

    after(:create) do |book, evaluator|
      book.price = evaluator.price
    end

    factory :book_with_review do
      after(:create) do |book, _evaluator|
        create_list(:review, 3, book_id: book.id)
      end
    end
  end
end
