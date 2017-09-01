FactoryGirl.define do
  factory :author do
    first_name FFaker::Book.author.split(' ').first
    last_name FFaker::Book.author.split(' ').last
    description FFaker::Book.description
  end
end
