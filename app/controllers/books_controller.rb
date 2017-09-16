class BooksController < ApplicationController
  before_action :set_book,       only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :show]
  before_action :set_current,    only: [:index]
  include SortOptions

  def index
    @books = if @current_category.id
               Book.by_category(@current_category.id).order(@sort_option).page params[:page]
             else
               Book.order(@sort_option).page params[:page]
             end
  end

  def show
    @reviews = @book.reviews
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

  def set_current
    @current_category = if params[:category_id] && Category.ids.include?(params[:category_id].to_i)
                          @categories.find(params[:category_id])
                        else
                          Category.new(id: nil, name: 'All')
                        end
    @sort_by = params[:sort_by]
    if params[:sort_by] && SortOptions.sort_options.keys.include?(params[:sort_by].to_sym)
      @sort_name = SortOptions.sort_options[@sort_by.to_sym][:name]
      @sort_option = SortOptions.sort_options[@sort_by.to_sym][:option]
    else
      @sort_name = 'Newest first'
      @sort_option = 'created_at DESC'
    end
  end
end
