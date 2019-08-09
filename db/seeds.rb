authors_count = ENV['AUTHORS_COUNT']&.to_i || 32
books_count = ENV['BOOKS_COUNT']&.to_i || 256
users_count = ENV['USERS_COUNT']&.to_i || 4
max_book_autors = 3
max_book_reviews = 4
categorise_list = ['Mobile development', 'Photo', 'Web design', 'Web development']

Book.__elasticsearch__.create_index!(force: true)

def book_authors(authors)
  selected_authors = []
  rand(1..3).times do
    author = authors.sample
    selected_authors << author unless selected_authors.include?(author)
  end
  selected_authors
end

def cover_url(options = {})
  base_url = 'https://orly-appstore.herokuapp.com/generate?'
  params = {
    title: options[:title] || 'Sample title',
    guide_text: options[:guide_text] || 'The Definitive Guide',
    top_text: options[:top_text] || 'Sample top text',
    author: options[:author] || 'Sample Author',
    image_code: rand(1..40),
    theme: rand(1..16)
  }
  base_url + params.to_query
end

Admin.create!(email: 'admin@example.com', password: "Qwerty123") if Rails.env.development?

users_count.times do
  new_user = User.new(
    email: FFaker::Internet.safe_email,
    password: "test#{rand(100...999)}XX",
    name: FFaker::Name.name,
    remote_avatar_url: FFaker::Avatar.image
  )
  new_user.skip_confirmation!
  new_user.save!
end

categorise_list.each do |category|
  Category.create(name: category)
end

authors_count.times do
  Author.create(
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    description: FFaker::Lorem.paragraph
  )
end

categories = Category.all

puts ''
puts 'create books'
books_count.times do |index|
  title = FFaker::Book.title
  description = Array.new(rand(1..2)).map { |x| FFaker::HipsterIpsum.paragraphs.join(' ') }.join(' ')
  materials = [
    'machine-finished coated paper',
    'woodfree uncoated paper',
    'coated fine paper',
    'recycled paper'
  ]

  new_book = Book.new(
    title: title,
    price: "#{rand(1..99)}.99".to_f,
    description: description,
    height: rand(7.5...10.0).floor(2),
    width: rand(4.5...5.5).floor(2),
    depth: rand(0.3...4.0).floor(2),
    isbn: FFaker::Book.isbn,
    publication_year: rand(2001..2017),
    materials: materials.sample,
    category_id: categories.sample.id,
  )

  parts_count = Book.count { |x| x.title.starts_with?(title) }
  unless parts_count.zero?
    new_book.title = "#{title} (Part #{parts_count + 1})"
    if parts_count == 1
      part_1 = Book.find_by(title: title)
      part_1.update(title: "#{title} (Part 1)") if part_1.present?
    end
  end
  new_book.save
  print '.'
end

authors = Author.all
books = Book.all
users = User.all

puts ''
puts 'assign authors to books'
Book.in_batches.each_record do |book|
  next unless book.authors.empty?
  book_authors(authors).each do |author|
    rand(1..max_book_autors).times { Authorship.create!(author_id: author.id, book_id: book.id) }
  end
  print '.'
end

puts ''
puts 'create book reviews'
Book.in_batches.each_record do |book|
  rand(1..max_book_reviews).times do
    Review.create!(
      title: FFaker::Lorem.words.join(', '),
      text: FFaker::Lorem.sentences.join('. '),
      rating: rand(1..5),
      status: rand(0..2),
      book_id: book.id,
      user_id: users.sample.id
    )
  end
  print '.'
end

puts ''
puts 'add book covers'
Book.in_batches.each_record do |book|
  author_names = book.authors.map { |a| [a.first_name, a.last_name] }
  author_text = author_names.size > 1 ? author_names.map { |a| "#{a.first[0]}. #{a.last}" }.join(', ') : author_names.join(' ')

  cover_params = {
    title: book.title,
    top_text: book.category.name,
    author: author_text,
  }

  book.update(remote_cover_url: cover_url(cover_params))
  print '.'
end

Book.import

Delivery.create(name: 'Delivery Next Day!', time: '3 to  7 days', price:  5.00)
Delivery.create(name: 'Pick Up In-Store',   time: '5 to 20 days', price: 10.00)
Delivery.create(name: 'Expressit',          time: '2 to  3 days', price: 15.00)

Coupon.create(code: 'TEST',       discount: 0.01)
Coupon.create(code: 'WINTERSALE', discount: 5.00)
Coupon.create(code: 'RUBYGARAGE', discount: 7.50)
