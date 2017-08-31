module BooksHelper
  def book_short_description(book)
    return book.description if book.description.length <= 50
    book.description.slice(0, 47).concat('...')
  end
end
