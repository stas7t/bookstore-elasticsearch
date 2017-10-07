require 'rails_helper'

RSpec.feature 'Cart', type: :feature do

  scenario 'Go to empty cart' do
    visit root_path
    find('a.shop-link.pull-right.hidden-xs').click

    expect(page.current_path).to eq cart_path
    expect(page).to have_content 'Cart is empty'
  end

  scenario 'Go to full cart' do
    FactoryGirl.create(:book)
    visit root_path
    click_button('Buy Now')
    find('a.shop-link.pull-right.hidden-xs').click

    expect(page.current_path).to eq cart_path
    expect(page).not_to have_content 'Cart is empty'
  end

  scenario 'Item details. Click on photo or title redirect to book page' do
    @book = FactoryGirl.create(:book)
    visit root_path
    click_button('Buy Now')
    find('a.shop-link.pull-right.hidden-xs').click

    expect(page.current_path).to eq cart_path
    expect(page).not_to have_content 'Cart is empty'

    within('.table.table-hover') do
      find('.general-img-wrap-table').find('a').click
    end
    expect(page.current_path).to eq book_path(@book)

    visit cart_path
    within('.table.table-hover') do
      find('.title-link').click
    end
    expect(page.current_path).to eq book_path(@book)
  end
end
