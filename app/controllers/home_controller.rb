class HomeController < ApplicationController
  def index
    @latest_books = Book.last(3)
    @bestsellers = Book.bestsellers.first(4)
  end
end
