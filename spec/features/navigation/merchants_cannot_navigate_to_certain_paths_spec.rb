require "rails_helper"

describe "User visits unauthorized paths" do
  context "as merchant" do
    it "does not allow merchants to navigate to any /profile path" do
      # merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
			# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      # visit profile_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit profile_orders_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit profile_edit_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit order_show_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow merchants to navigate to any /admin path" do
      # merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
			# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)
      #
      # visit admin_dashboard_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit admin_users_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
      #
      # visit admin_merchants_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "does not allow merchants to navigate to any /cart path" do
      # merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
			# allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      # visit cart_path
      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
