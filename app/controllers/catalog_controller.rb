class CatalogController < ApplicationController
  def index
    @books = Book.first(12)
    @categories = Category.all

  end
end