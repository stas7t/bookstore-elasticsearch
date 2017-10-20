feature 'log in' do
  background do
    @user = FactoryGirl.create(:user)
  end

  scenario 'Visitor logins successfully via log in form' do
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button('Log in')
    end
    expect(page.current_path).to eq root_path
    expect(page).not_to have_content 'Log in'
    expect(page).to have_content 'Log out'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Visitor forgots password' do
    visit new_user_session_path
    click_link('Forgot password?')
    expect(page.current_path).to eq new_user_password_path

    within '#new_user' do
      fill_in 'user_email', with: @user.email
      click_button('Email Instructions')
    end
    expect(page.current_path).to eq new_user_session_path
    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end
end
