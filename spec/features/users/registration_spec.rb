require 'rails_helper'

describe 'Signing up' do
  it 'allows a user to sign up for the site & creates the object in the database' do
    expect(User.count).to eq(0)

    visit '/'
    expect(page).to have_content('Sign up')
    within ('.nav') { click_link 'Sign up' }

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Doe'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: '12345'
    fill_in 'Password Confirmation', with: '12345'
    click_button 'Create User'

    expect(User.count).to eq(1)
  end
end
