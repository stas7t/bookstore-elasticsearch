require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
