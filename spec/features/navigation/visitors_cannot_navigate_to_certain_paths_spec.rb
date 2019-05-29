require "rails_helper"

describe "Visitor visits unauthorized paths" do
  context "as a visitor" do
    it "does not allow visitors to navigate to any /dashboard path" do
      visit dashboard_items_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit new_dashboard_item_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow visitors to navigate to any /admin path" do
      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit admin_users_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit admin_merchants_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow visitors to navigate to any /profile path" do
      visit profile_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit profile_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
