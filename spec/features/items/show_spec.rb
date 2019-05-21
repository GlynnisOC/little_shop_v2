require 'rails_helper'

# As any kind of user on the system
# When I visit an item's show page from the items catalog
# My URI route is something like "/items/18"
# I see all information for this item, including:
# - the name of the item
# - the description of the item
# - a larger image of the item
# - the merchant name who sells the item
# - how many of the item the merchant has in stock
# - the merchant's current price for the item
# - an average amount of time it takes this merchant to fulfill this item
#
# If I am a visitor or regular user, I also see a link to add this item to my cart

RSpec.describe 'As any user' do
  describe 'when I visit an item show page' do
		before :each do
			@merchant_1 = User.create!(email: "Bob@bob.bob", password_digest: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			@active_item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 100)
			@active_item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 200)

 			@inactive_item =  @merchant_1.items.create!(name: "this is a word", active: false, price: 2.00, description: "Buy things with your MONEY!", image: "fake url", inventory: 200)
		end

		it 'shows details about the item' do

			visit items_path

      within "#item-#{@active_item_1.id}" do
        click_link("#{@active_item_1.name}")
      end

      expect(current_path).to eq(item_path(@active_item_1))

  		expect(page).to have_content(@active_item_1.name)
  		expect(page).to have_content(@active_item_1.price)
  		expect(page).to have_css("img[src*='#{@active_item_1.image}']")
  		expect(page).to have_content(@active_item_1.user.name)
  		expect(page).to have_content(@active_item_1.inventory)

  		expect(page).to_not have_content(@inactive_item.name)
  		expect(page).to_not have_content(@active_item_2.name)
		end

    it 'shows the average amount of time it takes this merchant to fulfill this item'
    it 'shows a link to add to cart if visitor or regular user'
    
	end
end
