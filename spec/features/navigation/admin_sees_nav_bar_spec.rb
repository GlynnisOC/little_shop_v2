require 'rails_helper'

RSpec.describe "as an admin on the site" do
  describe "a navigation bar is seen" do
    it "allows admin to log in and see certain links" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit root_path

      click_link("Items")
      expect(current_path).to eq(items_path)

      click_link("Merchants")
      expect(current_path).to eq(merchants_path)

      click_link("Home")
      expect(current_path).to eq(root_path)

      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Cart")
    end

    it "allows admin to navigate to /dashboard" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit root_path

      expect(page).to have_link("Admin Dashboard")
      click_on "Admin Dashboard"
      expect(current_path).to eq(dashboard_path)
    end

    it "allows admin to log out" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit root_path

      visit root_path
      expect(page).to have_link("Logout")

      click_link("Logout")
      expect(current_path).to eq(root_path)
    end
  end
end
