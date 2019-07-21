# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource

  before_action :set_book,             only: %i[show update]
  before_action :set_order_item,       only: %i[index show update]
  before_action :set_categories,       only: %i[index show]
  before_action :set_current_category, only: %i[index]
  before_action :set_active_sort_name, only: %i[index]

  def index
    @books = Book.all
    @books = @books.by_category(@current_category.id) if @current_category.id.present?
    @books = @books.includes(:order_items) if params[:sort_by] == 'popular_first'
    @books = @books.order(sort_option).page(params[:page])
  end

  def show
    @reviews = @book.reviews.approved
  end

  def update
    @book.update(book_params)

    render :show
  end

  private

  def book_params
    params.require(:book).permit(:title, :price, :publication_year, :materials,
                                 :description, :height, :width, :depth,
                                 :cover, :cover_cache)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def set_order_item
    @order_item = OrderItem.new
  end

  def set_categories
    @categories = Category.order('name')
  end

  def set_current_category
    @current_category = Category.find_by(id: params[:category_id]) ||
                        Category.new(id: nil, name: 'All')
  end

  def sort_option
    return SORT_OPTIONS[:newest_first][:query] unless SORT_OPTIONS.key?(option_param)

    SORT_OPTIONS[option_param][:query]
  end

  def set_active_sort_name
    return @active_sort_name = SORT_OPTIONS[:newest_first][:name] unless SORT_OPTIONS.key?(option_param)

    @active_sort_name = SORT_OPTIONS[option_param][:name]
  end

  def option_param
    params[:sort_by]&.to_sym
  end
end
