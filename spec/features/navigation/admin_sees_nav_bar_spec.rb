require 'rails_helper'

RSpec.describe "as a admin on the site" do
  describe "a navigation bar is seen" do
    it "allows me to log in and see certain links" do
      admin_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: admin_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as admin

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Admin Dashboard") #a link to my admin dashboard ("/admin/dashboard")
      expect(page).to have_link("Log Out") #a link to log out ("/logout")

      expect(page).to_not have_link("Log In") #to log in or register
      expect(page).to_not have_link("Register")
      expect(page).to_not have_link("Cart") #a link to my shopping cart ("/cart") or count of cart items
      #expect(page).to_not have_ #count of items
    end

    it "allows me to navigate to /admin/dashboard" do
      admin_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: admin_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as admin

      click_on "Admin Dashboard"

      expect(current_path).to eq(admin_dashboard_path)
    end

    it "allows me to log out" do
      admin_1 = User.create!(name: "John Smith", email: "john.smith@gmail.com", password: "airplay")

      visit login_path

      fill_in :email, with: admin_1.email
      fill_in :password, with: user_1.password

      click_on "Log In" #log in as admin

      click_on "Log Out"

      expect(current_path).to eq(root_path)
    end
  end
end
