require 'rails_helper'

RSpec.describe "as a merchant on the site" do
  describe "a navigation bar is seen" do
    it "allows merchant to log in and see certain links" do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit root_path

      click_link("Items")
      expect(current_path).to eq(items_path)

      click_link("Merchants")
      expect(current_path).to eq(merchants_path)

      click_link("Home")
      expect(current_path).to eq(root_path)

      expect(page).to_not have_link("Login") #to log in or register
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Cart") #a link to my shopping cart ("/cart") or count of cart items
    end

    it "allows merchant to navigate to /dashboard" do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit root_path

      expect(page).to have_link("Merchant Dashboard") #a link to my merchant dashboard ("/dashboard")
      click_on "Merchant Dashboard"
      expect(current_path).to eq(dashboard_path)
    end

    it "allows merchant to log out" do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit root_path

      visit root_path
      expect(page).to have_link("Logout") #a link to log out ("/logout")
      expect(current_path).to eq(root_path)
    end
  end
end
