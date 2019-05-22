# As a visitor or registered user
# When I have added items to my cart
# And I visit my cart ("/cart")
# - [ ] I see all items I've added to my cart
# - [ ] And I see a link to empty my cart
# Each item in my cart shows the following information:
# - [ ] the name of the item
# - [ ] a very small thumbnail image of the item
# - [ ] the merchant I'm buying this item from
# - [ ] the price of the item
# - [ ] my desired quantity of the item
# - [ ] a subtotal (price multiplied by quantity)
#
# - [ ] I also see a grand total of what everything in my cart will cost
require 'rails_helper'

RSpec.describe "as a user on the site" do
  describe "a navigation bar is seen" do
    it "allows user to log in and see certain links" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit cart_path

      expect(page).to have_content(root_path)
    end
  end
end
