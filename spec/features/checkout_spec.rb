require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  before do
    FactoryGirl.create(:book)
    FactoryGirl.create_list(:delivery, 3)
  end

  scenario 'Checkout process' do
    login_as(user, scope: :user)
    visit root_path
    find('input[value="Buy Now"]').click
    find('a.shop-link.hidden-xs').click
    expect(page.current_path).to eq cart_path
    find('a[href="/checkout/login"].hidden-xs').click
    expect(page.current_path).to eq checkout_path(:addresses)

    within('form#new_addresses_form') do
      %w[billing shipping].each do |type|
        fill_in "addresses_form[#{type}][first_name]", with: 'Rick'
        fill_in "addresses_form[#{type}][last_name]", with: 'Sanchez'
        fill_in "addresses_form[#{type}][address]", with: 'Random street 42'
        fill_in "addresses_form[#{type}][city]", with: 'Dnipro'
        fill_in "addresses_form[#{type}][zip]", with: '49000'
        select('Ukraine', from: "addresses_form[#{type}][country]")
        fill_in "addresses_form[#{type}][phone]", with: '+380555555555'
      end

      click_button('Save and Continue')
    end

    expect(page.current_path).to eq checkout_path(:delivery)
    all('.radio-label').first.click
    click_button('Save and Continue')
    expect(page.current_path).to eq checkout_path(:payment)

    within('form#new_credit_card') do
      fill_in 'credit_card[number]', with: '1111222233334444'
      fill_in 'credit_card[name_on_card]', with: 'Rick Sanchez'
      fill_in 'credit_card[month_year]', with: '10/24'
      fill_in 'credit_card[cvv]', with: '123'

      click_button('Save and Continue')
    end

    expect(page.current_path).to eq checkout_path(:confirm)

    click_button('Place Order')
    expect(page.current_path).to eq checkout_path(:complete)
    expect(page).to have_content "An order confirmation has been sent to #{user.email}"
  end
end
