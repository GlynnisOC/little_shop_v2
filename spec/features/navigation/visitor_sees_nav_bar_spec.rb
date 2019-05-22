require 'rails_helper'

RSpec.describe "as a visitor on the site" do
  describe "a navigation bar is seen" do
    it "has working links that redirect" do
      visit root_path

      click_link("Items")
      expect(current_path).to eq(items_path)

      click_link("Merchants")
      expect(current_path).to eq(merchants_path)

      click_link("Home")
      expect(current_path).to eq(root_path)

      expect(page).to have_link("Cart")
      expect(page).to have_link("Login")
      expect(page).to have_link("Register")
    end
  end
end
