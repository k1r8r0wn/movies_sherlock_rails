require 'rails_helper'

describe 'Signing out' do
  it 'allows a log in user to log out' do
    user = create(:user)
    visit '/users/:id'
    expect(page).to have_content('Sign in')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345'
    click_button 'Sign in'

    expect(page).to have_content('Sign out')
    click_link 'Sign out'
    expect(page).to_not have_content('Sign out')
    expect(page).to have_content('Sign in')
  end
end
