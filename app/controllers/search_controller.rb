# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    @books = params[:q].nil? ? [] : Book.search(search_definition)

    respond_to do |format|
      format.html
      format.json { render json: @books.to_json }
    end
  end

  private

  def search_definition
    {
      query: {
        wildcard: {
          "title.raw": "*#{params[:q]}*"
        }
      },
      size: params[:limit] || 20
    }
  end
end
