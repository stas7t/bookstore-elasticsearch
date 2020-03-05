# frozen_string_literal: true

class BooksController < ApplicationController # rubocop:disable Metrics/ClassLength
  load_and_authorize_resource

  before_action :set_book,             only: %i[show update]
  before_action :set_order_item,       only: %i[index show update]
  before_action :set_categories,       only: %i[index show]
  before_action :set_current_category, only: %i[index]
  before_action :set_active_sort_name, only: %i[index]

  caches_action :show

  def index
    @books = params[:q].present? ? load_books_from_index : load_books_from_db
    @books = @books.page(params[:page])
    fresh_when @books
  end

  def show
    @reviews = @book.reviews.approved
    fresh_when @book
    fresh_when @reviews
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

  def load_books_from_db
    books = Book.all
    books = books.by_category(@current_category.id) if @current_category.id.present?
    books = books.includes(:order_items) if params[:sort_by] == 'popular_first'
    books = books.order(sort_option)
    books
  end

  def load_books_from_index
    Book.search(search_definition).records
  end

  def search_definition # rubocop:disable Metrics/MethodLength
    search_params = {
      query: {
        bool: {
          must: [
            {
              query_string: {
                query: "title:*#{params[:q]}*",
                analyze_wildcard: true,
                default_field: '*'
              }
            }
          ],
          filter: [],
          should: [],
          must_not: []
        }
      },
      sort: [
        search_sort
      ],
      size: params[:limit] || 1000
    }

    if @current_category.id.present?
      search_params[:query][:bool][:must] << {
        match_phrase: {
          'category.name': {
            query: @current_category.name
          }
        }
      }
    end

    search_params
  end

  def search_sort
    return { publication_year: { order: 'desc' } } unless option_param
    field = SORT_OPTIONS[option_param][:es][:field]
    order = SORT_OPTIONS[option_param][:es][:order]

    sort_hash = {}
    sort_hash["#{field}.raw"] = { order: order } if field.in?(%w[title])
    sort_hash[field] = { order: order } if field.in?(%w[publication_year sales price])
    sort_hash
  end
end
