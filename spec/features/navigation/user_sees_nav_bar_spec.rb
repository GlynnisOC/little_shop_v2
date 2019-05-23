# As a registered user
# I see the same links as a visitor
# Plus the following links
# - a link to my profile page ("/profile")
# - a link to log out ("/logout")
#
# Minus the following links
# - I do not see a link to log in or register
#
# I also see text that says "Logged in as Ian Douglas" (or whatever my name is)
require 'rails_helper'

RSpec.describe "as a user on the site" do
  describe "a navigation bar is seen" do
    it "allows user to log in and see certain links" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit root_path

      
      click_link("Items")
      expect(current_path).to eq(items_path)

      click_link("Home")
      expect(current_path).to eq(root_path)

      click_link("Merchants")
      expect(current_path).to eq(merchants_path)
   
      click_link("My Profile")
      expect(current_path).to eq(profile_path)

      click_link("Cart")
      expect(current_path).to eq(carts_path)

      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")

      click_link("Logout")
      expect(current_path).to eq(root_path)
    end

    it "allows merchant to navigate to /dashboard" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit root_path

      expect(page).to have_content("Logged in as #{user_1.name}")
      click_on "Merchants"
      expect(page).to have_content("Logged in as #{user_1.name}")
    end

    it "allows merchant to log out" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit root_path

      visit root_path
      expect(page).to have_link("Logout") #a link to log out ("/logout")

      click_link("Logout")
      expect(current_path).to eq(root_path)
    end
  end
end
