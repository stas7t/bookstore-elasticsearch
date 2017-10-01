class HomeController < ApplicationController
  def index
    @latest_books = Book.last(3)
    @bestsellers = Category.ids.map { |c_id| Book.bestsellers(c_id).first }
  end
end
