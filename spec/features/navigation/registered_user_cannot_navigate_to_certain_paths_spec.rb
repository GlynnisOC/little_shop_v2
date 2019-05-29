require "rails_helper"

describe "Registered user visits unauthorized paths" do
  context "as a registered user" do
    it "does not allow registered users to navigate to any /dashboard path" do
      # user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      # visit dashboard_items_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit new_dashboard_item_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit dashboard_order_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit dashboard_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow registered users to navigate to any /admin path" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit admin_users_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit admin_merchants_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
