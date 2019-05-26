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

	describe "I see statistics when I visit the merchant dashboard" do
		before :each do
			@merchant = User.create!(email: "merchant@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)
			@user_1		= User.create!(email: "user_1@email.com", 	password: "password", role: "default",  name: "user_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 00001)
			@user_2		= User.create!(email: "user_2@email.com", 	password: "password", role: "default",  name: "user_name_2", address: "2000 Abc Street", city: "City_1", state: "AB", zip: 00002)
			@user_3		= User.create!(email: "user_3@email.com", 	password: "password", role: "default",  name: "user_name_3", address: "3000 Abc Street", city: "City_1", state: "AB", zip: 00003)
			@user_4 	= User.create!(email: "user_4@email.com", 	password: "password", role: "default",  name: "user_name_4", address: "4000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_5 	= User.create!(email: "user_5@email.com", 	password: "password", role: "default",  name: "user_name_5", address: "5000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_6 	= User.create!(email: "user_6@email.com", 	password: "password", role: "default",  name: "user_name_6", address: "6000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_7 	= User.create!(email: "user_7@email.com", 	password: "password", role: "default",  name: "user_name_7", address: "7000 Abc Street", city: "City_1", state: "Ad", zip: 00004)

			@item_1 = @merchant.items.create!(name: "Item One", 	active: true,  price: 1.00, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
			@item_2 = @merchant.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
			@item_3 = @merchant.items.create!(name: "Item Three", active: true,  price: 3.00, description: "This is item three", image: "https://picsum.photos/200/300?image=1", inventory: 300)
			@item_4 = @merchant.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)
			@item_5 = @merchant.items.create!(name: "Item Five", 	active: true,  price: 5.00, description: "This is item five",  image: "https://picsum.photos/200/300?image=1", inventory: 500)
			@item_6 = @merchant.items.create!(name: "Item Six", 	active: true,  price: 6.00, description: "This is item six", 	 image: "https://picsum.photos/200/300?image=1", inventory: 600)
			@item_7 = @merchant.items.create!(name: "Item Seven",	active: true,  price: 6.00, description: "This is item seven", image: "https://picsum.photos/200/300?image=1", inventory: 700)

      @order_1 = @user_1.orders.create(status: 2)
      @order_2 = @user_2.orders.create(status: 2)
      @order_3 = @user_3.orders.create(status: 2)
      @order_4 = @user_4.orders.create(status: 2)
      @order_5 = @user_5.orders.create(status: 2)
      @order_6 = @user_6.orders.create(status: 2)
      @order_7 = @user_7.orders.create(status: 2)
      @order_8 = @user_7.orders.create(status: 2)

			@order_item_1a = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: true)
			@order_item_1b = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: false)

			@order_item_2a = @item_2.order_items.create!(item: @item_2, order: @order_2, quantity: 6, price: 5.00, fulfilled: true)
			@order_item_2b = @item_2.order_items.create!(item: @item_2, order: @order_2, quantity: 6, price: 5.00, fulfilled: false)

			@order_item_3a = @item_3.order_items.create!(item: @item_3, order: @order_3, quantity: 5, price: 5.00, fulfilled: true)
			@order_item_3b = @item_3.order_items.create!(item: @item_3, order: @order_3, quantity: 5, price: 5.00, fulfilled: false)

			@order_item_4a = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 5.00, fulfilled: true)
			@order_item_4b = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 5.00, fulfilled: false)

			@order_item_5a = @item_5.order_items.create!(item: @item_5, order: @order_5, quantity: 3, price: 5.00, fulfilled: true)
			@order_item_5b = @item_5.order_items.create!(item: @item_5, order: @order_5, quantity: 3, price: 5.00, fulfilled: false)

			@order_item_6a = @item_6.order_items.create!(item: @item_6, order: @order_6, quantity: 1, price: 5.00, fulfilled: true)
			@order_item_6b = @item_6.order_items.create!(item: @item_6, order: @order_6, quantity: 1, price: 5.00, fulfilled: false)

			@order_item_7a = @item_7.order_items.create!(item: @item_7, order: @order_7, quantity: 1, price: 5.00, fulfilled: true)
			@order_item_7b = @item_7.order_items.create!(item: @item_7, order: @order_7, quantity: 1, price: 5.00, fulfilled: false)

			@order_item_8a = @item_7.order_items.create!(item: @item_7, order: @order_8, quantity: 1, price: 5.00, fulfilled: true)
			@order_item_8b = @item_7.order_items.create!(item: @item_7, order: @order_8, quantity: 1, price: 5.00, fulfilled: false)

			visit login_path

			fill_in "Email", with:  "merchant@email.com"
			fill_in "Password", with: "password"
			click_button("Login")

			visit dashboard_path
		end

			# [ ] - top 5 items I have sold by quantity, and the quantity of each that I've sold
			# [ ] - total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory (eg, if I have sold 1,000 things and still have 9,000 things in inventory, the message would say something like "Sold 1,000 items, which is 10% of your total inventory")
			# [ ] - top 3 states where my items were shipped, and their quantities
			# [ ] - top 3 city/state where my items were shipped, and their quantities (Springfield, MI should not be grouped with Springfield, CO)
			# [ ] - name of the user with the most orders from me (pick one if there's a tie), and number of orders
			# [ ] - name of the user who bought the most total items from me (pick one if there's a tie), and the total quantity
			# [ ] - top 3 users who have spent the most money on my items, and the total amount they've spent

		it "top 5 items I have sold by quantity, and the quantity of each that I've sold" do
			within "#merchant-dash-stats" do
				expect(page.all('li')[0]).to have_content("#{@item_1.name}: 7 Sold")
				expect(page.all('li')[1]).to have_content("#{@item_2.name}: 6 Sold")
				expect(page.all('li')[2]).to have_content("#{@item_3.name}: 5 Sold")
				expect(page.all('li')[3]).to have_content("#{@item_4.name}: 4 Sold")
				expect(page.all('li')[4]).to have_content("#{@item_5.name}: 3 Sold")

				expect(page).to_not have_content("#{@item_6.name}: 2 Sold")
			end
		end

		xit "total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

		xit "top 3 states where my items were shipped, and their quantities" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

		xit "top 3 city/state where my items were shipped, and their quantities" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

		xit "name of the user with the most orders from me" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

		xit "name of the user who bought the most total items from me" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

		xit "top 3 users who have spent the most money on my items, and the total amount they've spent" do
			within "#x" do
				expect(page).to have_content("x")
			end
		end

	end
end
