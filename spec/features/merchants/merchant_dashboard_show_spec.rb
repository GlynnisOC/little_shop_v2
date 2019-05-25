require 'rails_helper'

RSpec.describe 'As a registered merchant on the site' do
	describe 'when I visit my dashboard' do
		it 'shows my data and I cannot edit it' do
			merchant = User.create!(email: "jimbob@bob.bob", password: "password", role: "merchant", name: "jimbob", address: "321 blastoff st", city: "Big Greasy Easy", state: "LA", zip: 38511)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

			visit dashboard_path

			within "#merchant-profile-info" do
				expect(page).to have_content("Name: #{merchant.name}")
				expect(page).to have_content("Email: #{merchant.email}")
				expect(page).to have_content("Address: #{merchant.address}")
				expect(page).to have_content("City: #{merchant.city}")
				expect(page).to have_content("State: #{merchant.state}")
				expect(page).to have_content("Zip Code: #{merchant.zip}")
			end
		end
	end

	describe "When I visit my items page '/dashboard/items'" do
		before :each do
			@merchant = User.create!(email: "merchant@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)
			@user 		= User.create!(email: "user@email.com", password: "password", role: "default", name: "Yu Xer", address: "1600 Pennsylvania Ave", city: "Userton", state: "US", zip: 12345)

			@item_1 = @merchant.items.create!(name: "Item One", active: true, price: 1.00, description: "This is item one", image: "https://picsum.photos/200/300?image=1", inventory: 100)
			@item_2 = @merchant.items.create!(name: "Item Two", active: true, price: 2.00, description: "This is item two", image: "https://picsum.photos/200/300?image=1", inventory: 200)
			@item_3 = @merchant.items.create!(name: "Item Three", active: false, price: 3.00, description: "This is item three", image: "https://picsum.photos/200/300?image=1", inventory: 300)

			@order_1 = Order.create!(status: 0, user_id: @user.id)

			@order_item_1 = OrderItem.create!(item_id: @item_1.id, order_id: @order_1.id, quantity: 1, price: 1.00, fulfilled: false)

			visit login_path

			fill_in "Email", with:  "merchant@email.com"
			fill_in "Password", with: "password"
			click_button("Login")
		end

		it "I see a link to add a new item to the system" do
			visit dashboard_items_path

			expect(page).to have_link("Add new item")
		end

		it "I see details about each item I've added to the system" do
			visit dashboard_items_path

			within "#merchant-item-#{@item_1.id}" do
				expect(page).to have_content("Item ID: #{@item_1.id}")
				expect(page).to have_content("#{@item_1.name}")
				expect(page).to have_css("img[src*='#{@item_1.image}']")
				expect(page).to have_content("Current Price: #{@item_1.price}")
				expect(page).to have_content("Inventory: #{@item_1.inventory}")
				expect(page).to have_link("Edit #{@item_1.name}")
				expect(page).to have_link("Disable")

			end

			within "#merchant-item-#{@item_2.id}" do
				expect(page).to have_content("Item ID: #{@item_2.id}")
				expect(page).to have_content("#{@item_2.name}")
				expect(page).to have_css("img[src*='#{@item_2.image}']")
				expect(page).to have_content("Current Price: #{@item_2.price}")
				expect(page).to have_content("Inventory: #{@item_2.inventory}")
				expect(page).to have_link("Edit #{@item_2.name}")
				expect(page).to have_link("Disable")
				expect(page).to have_link("Delete Item")
			end

			within "#merchant-item-#{@item_3.id}" do
				expect(page).to have_content("Item ID: #{@item_3.id}")
				expect(page).to have_content("#{@item_3.name}")
				expect(page).to have_css("img[src*='#{@item_3.image}']")
				expect(page).to have_content("Current Price: #{@item_3.price}")
				expect(page).to have_content("Inventory: #{@item_3.inventory}")
				expect(page).to have_link("Edit #{@item_3.name}")
				expect(page).to have_link("Enable")
				expect(page).to have_link("Delete Item")
			end
		end
	end
end
