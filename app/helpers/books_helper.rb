# frozen_string_literal: true

module BooksHelper
  def book_authors(book)
    book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def book_dimensions(book)
    "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}\""
  end
end
