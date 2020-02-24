# frozen_string_literal: true

class HomeController < ApplicationController
  caches_action :index

  def index
    @latest_books = Book.last(3)
    @best_sellers = Book.best_sellers.first(4)
    fresh_when @latest_books
    fresh_when @best_sellers
  end
end
