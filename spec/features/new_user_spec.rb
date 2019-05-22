require 'rails_helper'

RSpec.describe "when I click on the 'register' link in the nav bar" do
  it "allows me to register as a user" do
    visit new_user_path

    fill_in 'Name', with: 'Blair Williams'
    fill_in 'Street Address', with: '123 W. 6th Avenue'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip Code', with: '80221'
    fill_in 'Email Address', with: 'bwilliams@gmail.com'
    fill_in 'Password', with: 'serena123'
    fill_in 'Confirm Password', with: 'serena123'
    click_on("Register as a User")

    user = User.find_by(name: "Blair Williams")

    expect(current_path).to eq('/profile')

    expect(page).to have_content("You're logged in!")
  end

  it "doesn't let me partially fill out the form" do
    visit new_user_path

    fill_in 'Name', with: 'Blair Williams'
    fill_in 'Street Address', with: '123 W. 6th Avenue'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip Code', with: '80221'
    fill_in 'Email Address', with: ''
    fill_in 'Password', with: 'serena123'
    fill_in 'Confirm Password', with: ''
    click_on("Register as a User")

    expect(page).to have_content("You are missing required fields to register.")
    expect(current_path).to eq(users_path)
  end
end
