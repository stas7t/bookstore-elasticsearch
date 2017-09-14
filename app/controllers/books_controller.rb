class BooksController < ApplicationController

  before_action :set_book,       only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :show]
  before_action :set_current,    only: [:index, :show]
  after_action  :set_cookies,    only: [:index]

  def index
    @books = Book.all.order(params[:sort_by]).page params[:page] unless params[:category_id]
    @books = Book.by_category(params[:category_id]).order(params[:sort_by]).page params[:page] if params[:category_id]
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  def update
    if @book.update_attributes(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :price, :quantity, :description,
                                 :height, :width, :depth, :publication_year,
                                 :materials)
  end

  def set_categories
    @categories = Category.order('name')
  end

  def set_cookies
    cookies[:current_category] = params[:category_id]
    cookies[:sort_by]          = params[:sort_by]
  end

  def set_current
    @current_category = params[:category_id] || cookies[:current_category]
    @sort_by          = params[:sort_by]     || cookies[:sort_by]
  end
end
