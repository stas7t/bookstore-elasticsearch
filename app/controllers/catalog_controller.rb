class CatalogController < ApplicationController
  def index
    @books = Book.order(:title).page params[:page]
    @categories = Category.order('name')

  end
end