# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
10.times do
  User.create(email: FFaker::Internet.safe_email,
              password: "P1-#{FFaker::Internet.password}",
              name: FFaker::Name.name,
              image: FFaker::Avatar.image)
end

users = User.all

10.times do
  Author.create(first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                description: FFaker::Lorem.paragraph)
end

authors = Author.all

10.times do
  Book.create(name: FFaker::Book.title,
              description: FFaker::Book.description)
end

=end

categories = Category.create([{ name: 'Mobile development' },
                              { name: 'Photo' },
                              { name: 'Web design' },
                              { name: 'Web development' }])
                              