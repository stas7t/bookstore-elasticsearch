# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



user = User.create(email: FFaker::Internet.safe_email,
              password: "P1-#{FFaker::Internet.password}",
              name: FFaker::Name.name,
              image: FFaker::Avatar.image)

Category.create(name: 'Mobile development')
Category.create(name: 'Photo')
Category.create(name: 'Web design')
Category.create(name: 'Web development')

categories = Category.all

10.times do
  Author.create(first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                description: FFaker::Lorem.paragraph)
end

authors = Author.all

20.times do
  Book.create(title: FFaker::Book.title,
              price: [5.99, 10.99, 19.99, 29.99].sample,
              quantity: 1,
              description: FFaker::Book.description,
              height: 7.40,
              width: 4.50,
              depth: 0.90,
              publication_year: (1990..2017).to_a.sample,
              materials: FFaker::HipsterIpsum.words,
              authors: [authors.sample, authors.sample],
              categories: [categories.sample])
end

book = Book.first

3.times do
  Review.create(title: FFaker::HipsterIpsum.words,
                text: FFaker::HipsterIpsum.sentences,
                rating: (1..5).to_a.sample,
                book_id: book.id,
                user_id: user.id)
end
