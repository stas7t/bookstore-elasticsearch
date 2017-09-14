class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  @categories = Category.order('name')
end
