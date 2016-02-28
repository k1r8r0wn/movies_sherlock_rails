require 'rails_helper'

describe 'Signing in' do
  it 'logs the user in and goes to the users path' do
    create(:user)
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: '12345'
    click_button 'Sign in'

    expect(page).to have_content('My personal page')
    expect(page).to have_content('You are logged in.')
  end

  it 'displays the email address in the event of a failed sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'incorrect'
    click_button 'Sign in'

    expect(page).to have_content('There was a problem logging in. Please check your email and password.')
    expect(page).to have_field('Email', with: 'john@doe.com')
  end
end
