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
    click_link("Register as a User")
  end
end
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
