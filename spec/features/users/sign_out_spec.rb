require 'rails_helper'

describe 'Signing out' do
  it 'allows a log in user to log out' do
    user = create(:user)
    visit '/users/:id'
    expect(page).to have_content('Sign In')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '12345'
    click_button 'Sign in'

    expect(page).to have_content('Sign Out')
    click_link 'Sign Out'
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Sign In')
  end
end
