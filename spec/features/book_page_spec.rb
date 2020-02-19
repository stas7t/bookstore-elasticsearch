require 'rails_helper'

RSpec.describe 'Book Page', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @book = FactoryGirl.create(:book)
    login_as(user, scope: :user)
    visit book_path(@book)
  end

  xscenario 'Add to cart' do
    click_button('Add to Cart')
    expect(page).to have_css('.hidden-xs .shop-icon .shop-quantity', text: '1')
  end

  scenario 'Write a review' do
    within('#new_review') do
      select('4', from: 'review[rating]')
      fill_in 'Title', with: 'Title test'
      fill_in 'Review', with: 'Review test'
    end
    click_button 'Post'

    expect(page).to have_content 'Thanks for Review'
  end
end
