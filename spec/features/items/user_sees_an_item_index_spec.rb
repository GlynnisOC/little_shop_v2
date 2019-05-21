require 'rails_helper'

RSpec.describe 'As a user on the items index page' do
  describe 'I see all enabled items in the database' do
		before :each do 
			@merchant_1 = User.create!(email: "Bob@bob.bob", password_digest: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			@active_item = @merchant_1.items.create!(name: "name", active: true, price: 2.20, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 500)

 			@inactive_item =  @merchant_1.items.create!(name: "this is a word", active: false, price: 3.20, description: "Buy things with your MONEY!", image: "fake url", inventory: 500)
		end

		it 'shows the name, thumbnail, merchant, inventory stock, and current price' do
			visit items_path

			within "#item-#{@active_item.id}" do
				expect(page).to have_content(@active_item.name)
				expect(page).to have_content(@active_item.price)
				expect(page).to have_css("img[src*='#{@active_item.image}']") 
				expect(page).to have_content(@active_item.user.name)
				expect(page).to have_content(@active_item.inventory)
			end

				expect(page).to_not have_content(@inactive_item.name)
		end
	end
end
