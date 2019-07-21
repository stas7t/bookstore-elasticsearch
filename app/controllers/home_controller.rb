# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_books = Book.last(3)
    @best_sellers = Book.best_sellers.first(4)
  end
end
