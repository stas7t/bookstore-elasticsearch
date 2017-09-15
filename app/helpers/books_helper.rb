module BooksHelper
  def book_short_description(book, size = 50)
    return book.description if book.description.length <= size
    book.description.slice(0, size - 3).concat('...')
  end

  def book_authors(book)
    book.authors.map { |author| author_name(author) }.join(', ')
  end
  
  def book_dimensions(book)
    "H: #{book.height}\" x W: #{book.width}\" x D: #{book.depth}\""
  end
end
