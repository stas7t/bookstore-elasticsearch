class HomeController < ApplicationController
  def index
    @latest_books = Book.last(3)
    # Temporary decision
    # TODO: rework to really bestsellers
    @bestsellers = Book.last(4)
  end
end
