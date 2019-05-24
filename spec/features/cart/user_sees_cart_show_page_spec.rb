# As a visitor or registered user
# When I have added items to my cart
# And I visit my cart ("/cart")
# - [x] I see all items I've added to my cart
# - [x] And I see a link to empty my cart
# Each item in my cart shows the following information:
# - [x] the name of the item
# - [x] a very small thumbnail image of the item
# - [x] the merchant I'm buying this item from
# - [x] the price of the item
# - [x] my desired quantity of the item
# - [x] a subtotal (price multiplied by quantity)
#
# - [x] I also see a grand total of what everything in my cart will cost
require 'rails_helper'

RSpec.describe "as a user on the site" do
  describe "I have added items to cart and visit /cart" do
    it "shows all the items added to the cart" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      merchant_1 = User.create!(email: "Rob@rob.rob", password: "password", role: 1, active: true, name: "Rob Rob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      active_item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 2.20, description: "Buy things with your LAND!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 400)
      active_item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 2.40, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 500)
      active_item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 3.50, description: "Buy things with your EMOTIONS!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 600)

      visit item_path(active_item_1.id)

      expect(page).to have_content("Cart: 0")

      within("#user-nav-cart") do
        click_button "Add to Cart"
      end

      visit item_path(active_item_1.id)

      expect(page).to have_content("Cart: 1")

      within("#user-nav-cart") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("Cart: 2")

      visit item_path(active_item_2.id)

      within("#user-nav-cart") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("Cart: 3")

      visit cart_path
      expect(page).to have_content("Item Name: #{active_item_1.name}")
      expect(page).to have_xpath("//img[contains(@src,'#{active_item_1.image}')]")
      expect(page).to have_content("Merchant: #{merchant_1.name}")
      expect(page).to have_content("Price: $#{active_item_1.price}0")
      expect(page).to have_content("Desired Quantity: 2")
      expect(page).to have_content("Subtotal Price: $4.40")

      expect(page).to have_content("Item Name: #{active_item_2.name}")
      expect(page).to have_xpath("//img[contains(@src,'#{active_item_2.image}')]")
      expect(page).to have_content("Merchant: #{merchant_1.name}")
      expect(page).to have_content("Price: $#{active_item_2.price}0")
      expect(page).to have_content("Desired Quantity: 1")
      expect(page).to have_content("Subtotal Price: $2.40")

      expect(page).to have_content("Grand Total: $6.80")

      click_link "Empty Cart"

      expect(page).to have_content("Cart: 0")
    end
  end
end

RSpec.describe "as a visitor on the site" do
  describe "visitor added items to cart and visited /cart" do
    it "shows visitor all the items added to the cart" do
      merchant_1 = User.create!(email: "Rob@rob.rob", password: "password", role: 1, active: true, name: "Rob Rob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      active_item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 2.20, description: "Buy things with your LAND!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 400)
      active_item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 2.40, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 500)
      active_item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 3.50, description: "Buy things with your EMOTIONS!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 600)

      visit item_path(active_item_1.id)

      expect(page).to have_content("Cart: 0")

      within("#visitor-nav-cart") do
        click_button "Add to Cart"
      end

      visit item_path(active_item_1.id)

      expect(page).to have_content("Cart: 1")

      within("#visitor-nav-cart") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("Cart: 2")

      visit item_path(active_item_2.id)

      within("#visitor-nav-cart") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("Cart: 3")

      visit cart_path
      expect(page).to have_content("Item Name: #{active_item_1.name}")
      expect(page).to have_xpath("//img[contains(@src,'#{active_item_1.image}')]")
      expect(page).to have_content("Merchant: #{merchant_1.name}")
      expect(page).to have_content("Price: $#{active_item_1.price}0")
      expect(page).to have_content("Desired Quantity: 2")
      expect(page).to have_content("Subtotal Price: $4.40")

      expect(page).to have_content("Item Name: #{active_item_2.name}")
      expect(page).to have_xpath("//img[contains(@src,'#{active_item_2.image}')]")
      expect(page).to have_content("Merchant: #{merchant_1.name}")
      expect(page).to have_content("Price: $#{active_item_2.price}0")
      expect(page).to have_content("Desired Quantity: 1")
      expect(page).to have_content("Subtotal Price: $2.40")

      expect(page).to have_content("Grand Total: $6.80")

      click_link "Empty Cart"

      expect(page).to have_content("Cart: 0")
    end
  end
end
