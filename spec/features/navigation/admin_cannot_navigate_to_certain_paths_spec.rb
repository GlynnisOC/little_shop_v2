require "rails_helper"

describe "User visits unauthorized paths" do
  context "as admin" do
    it "does not allow admins to navigate to any /profile path" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit profile_path
      expect(page.status_code).to eq(404)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow admins to navigate to any /dashboard path" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit dashboard_items_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit new_dashboard_item_path
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow admins to navigate to any /cart path" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit cart_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
