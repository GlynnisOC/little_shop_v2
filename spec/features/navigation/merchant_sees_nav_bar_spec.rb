require 'rails_helper'

RSpec.describe "as a merchant on the site" do
  describe "a navigation bar is seen" do
    it "allows me to log in and see certain links" do
      merchant_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: merchant_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as merchant

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link("Merchant Dashboard") #a link to my merchant dashboard ("/dashboard")
      expect(page).to have_link("Log Out") #a link to log out ("/logout")

      expect(page).to_not have_link("Log In") #to log in or register
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Cart") #a link to my shopping cart ("/cart") or count of cart items
    end

    it "allows me to navigate to /dashboard" do
      merchant_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: merchant_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as merchant

      click_on "Merchant Dashboard"

      expect(current_path).to eq(dashboard_path)
    end

    it "allows me to log out" do
      merchant_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: merchant_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as merchant

      click_on "Log Out"

      expect(current_path).to eq(root_path)
    end
  end
end
