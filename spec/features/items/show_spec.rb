require 'rails_helper'

RSpec.describe 'As any user' do
  describe 'when I visit an item show page' do
		before :each do
			@merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

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
