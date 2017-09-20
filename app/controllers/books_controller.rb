class BooksController < ApplicationController
  before_action :set_book,       only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :show]
  before_action :set_current,    only: [:index]

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
    params.require(:book).permit(:title, :price, :publication_year, :description,
                                 :height, :width, :depth, :materials)
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
    if params[:sort_by] && SORT_OPTIONS.keys.include?(params[:sort_by].to_sym)
      @sort_name   = SORT_OPTIONS[@sort_by.to_sym][:name]
      @sort_option = SORT_OPTIONS[@sort_by.to_sym][:query]
    else
      @sort_name   = SORT_OPTIONS[:newest_first][:name]
      @sort_option = SORT_OPTIONS[:newest_first][:query]
    end
  end
end
