require 'rails_helper'

RSpec.describe 'As a registered merchant on the site' do
	describe 'when I visit my dashboard' do
		it 'shows my data and I cannot edit it' do
			merchant = User.create!(email: "jimbob@bob.bob", password: "password", role: "merchant", name: "jimbob", address: "321 blastoff st", city: "Big Greasy Easy", state: "LA", zip: 38511)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

			visit dashboard_path

			within "#merchant-#{merchant.id}-profile-info" do
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

			expect(page).to have_link("Add New Item")
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
				expect(page).to have_button("Disable")
			end

			within "#merchant-item-#{@item_2.id}" do
				expect(page).to have_content("Item ID: #{@item_2.id}")
				expect(page).to have_content("#{@item_2.name}")
				expect(page).to have_css("img[src*='#{@item_2.image}']")
				expect(page).to have_content("Current Price: #{@item_2.price}")
				expect(page).to have_content("Inventory: #{@item_2.inventory}")
				expect(page).to have_link("Edit #{@item_2.name}")
				expect(page).to have_button("Disable")
				expect(page).to have_button("Delete Item")
			end

			within "#merchant-item-#{@item_3.id}" do
				expect(page).to have_content("Item ID: #{@item_3.id}")
				expect(page).to have_content("#{@item_3.name}")
				expect(page).to have_css("img[src*='#{@item_3.image}']")
				expect(page).to have_content("Current Price: #{@item_3.price}")
				expect(page).to have_content("Inventory: #{@item_3.inventory}")
				expect(page).to have_link("Edit #{@item_3.name}")
				expect(page).to have_button("Enable")
				expect(page).to have_button("Delete Item")
			end
		end

		it "I see a link to add a new item" do
			visit dashboard_items_path

			click_link("Add New Item")

			expect(current_path).to eq(new_dashboard_item_path)
		end

		it "I'm taken to form to edit item when I click link to edit" do
			visit dashboard_items_path

			click_link("Edit #{@item_1.name}")

			expect(current_path).to eq(edit_dashboard_item_path(@item_1.id))

			fill_in "Name", with: "Edited Item Name"
      fill_in "Description", with: "Edited item description"

      click_button("Update Item")

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Your item has been updated!")
      expect(@item_1.reload.name).to eq("Edited Item Name")
      expect(@item_1.reload.description).to eq("Edited item description")

		end
	end

	describe "when I visit the page to add a new item" do
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

		it "I see a form where I can add information for a new item" do
			visit new_dashboard_item_path

			fill_in 'Name', with: 'New Item'
			fill_in 'Description', with: 'This is the description for a new item.'
			fill_in 'Image', with: 'https://bit.ly/2Ey9spB'
			fill_in 'Price', with: 1.00
			fill_in 'Available Inventory', with: 5

			click_button("Add Item")

			new_item = Item.find_by(name: "New Item")

			expect(current_path).to eq(dashboard_items_path)
			expect(page).to have_content("Your new item has been saved")
			expect(page).to have_content(new_item.name)
			expect(page).to have_css("img[src*='#{new_item.image}']")

		end

		it "name and description fields can't be blank" do
			visit new_dashboard_item_path

			fill_in 'Price', with: -1.00
			fill_in 'Available Inventory', with: -1

			click_button("Add Item")

			expect(page).to have_content("Name can't be blank")
			expect(page).to have_content("Description can't be blank")
			expect(page).to have_content("Price must be greater than 0")
			expect(page).to have_content("Inventory must be greater than or equal to 0")

		end

		it "price can't be less than $0.00" do
			visit new_dashboard_item_path

			fill_in 'Name', with: "New Item"
			fill_in 'Description', with: "New item description"
			fill_in 'Image', with: 'https://bit.ly/2Ey9spB'
			fill_in 'Price', with: -1.00
			fill_in 'Available Inventory', with: 1

			click_button("Add Item")

			expect(page).to have_content("Price must be greater than 0")

		end

		it "quantity can't be less than 0" do
			visit new_dashboard_item_path

			fill_in 'Name', with: "New Item"
			fill_in 'Description', with: "New item description"
			fill_in 'Image', with: 'https://bit.ly/2Ey9spB'
			fill_in 'Price', with: 1.00
			fill_in 'Available Inventory', with: -1

			click_button("Add Item")

			expect(page).to have_content("Inventory must be greater than or equal to 0")

		end

		it "image can be left blank and if it is then a default image is given" do
			visit new_dashboard_item_path

			fill_in 'Name', with: "New Item"
			fill_in 'Description', with: "New item description"
			fill_in 'Price', with: 1.00
			fill_in 'Available Inventory', with: 0

			click_button("Add Item")

			new_item = Item.find_by(name: "New Item")
			default_img = 'https://bit.ly/2HWf7qo'

			expect(current_path).to eq(dashboard_items_path)
			expect(page).to have_content("Your new item has been saved")
			expect(page).to have_content(new_item.name)
			expect(page).to have_css("img[src*='#{default_img}']")

		end
	end

	describe "I see statistics when I visit the merchant dashboard" do
		before :each do
			@merchant = User.create!(email: "merchant@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)
			@merchant2 = User.create!(email: "merchant2@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)

			@user_1		= User.create!(email: "user_1@email.com", 	password: "password", role: "default",  name: "user_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 00001)
			@user_2		= User.create!(email: "user_2@email.com", 	password: "password", role: "default",  name: "user_name_2", address: "2000 Abc Street", city: "City_1", state: "AB", zip: 00002)
			@user_3		= User.create!(email: "user_3@email.com", 	password: "password", role: "default",  name: "user_name_3", address: "3000 Abc Street", city: "City_1", state: "AB", zip: 00003)
			@user_4 	= User.create!(email: "user_4@email.com", 	password: "password", role: "default",  name: "user_name_4", address: "4000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_5 	= User.create!(email: "user_5@email.com", 	password: "password", role: "default",  name: "user_name_5", address: "5000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_6 	= User.create!(email: "user_6@email.com", 	password: "password", role: "default",  name: "user_name_6", address: "6000 Abc Street", city: "City_1", state: "AC", zip: 00004)
			@user_7 	= User.create!(email: "user_7@email.com", 	password: "password", role: "default",  name: "user_name_7", address: "7000 Abc Street", city: "City_1", state: "AD", zip: 00004)

			@item_1 = @merchant.items.create!(name: "Item One", 	active: true,  price: 1.00, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
			@item_2 = @merchant.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
			@item_3 = @merchant.items.create!(name: "Item Three", active: true,  price: 3.00, description: "This is item three", image: "https://picsum.photos/200/300?image=1", inventory: 300)
			@item_4 = @merchant.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)
			@item_5 = @merchant.items.create!(name: "Item Five", 	active: true,  price: 5.00, description: "This is item five",  image: "https://picsum.photos/200/300?image=1", inventory: 500)
			@item_6 = @merchant.items.create!(name: "Item Six", 	active: true,  price: 6.00, description: "This is item six", 	 image: "https://picsum.photos/200/300?image=1", inventory: 600)
			@item_7 = @merchant.items.create!(name: "Item Seven",	active: true,  price: 6.00, description: "This is item seven", image: "https://picsum.photos/200/300?image=1", inventory: 700)
			@item_8 = @merchant2.items.create!(name: "Item Seven",	active: true,  price: 6.00, description: "This is item seven", image: "https://picsum.photos/200/300?image=1", inventory: 700)

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

			@order_item_4a = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 55.00, fulfilled: true)
			@order_item_4b = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 55.00, fulfilled: false)

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

		it "total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory" do
			within "#total-items-sold" do
				expect(page).to have_content("Sold 28 items, which is 1% of your total inventory")
			end
		end

		it "top 3 states where my items were shipped, and their quantities" do
			within "#top-three-states-for-items-shipped" do
				expect(page.all('li')[0]).to have_content("State of #{@user_2.state}: 22 items shipped")
				expect(page.all('li')[1]).to have_content("State of #{@user_4.state}: 16 items shipped")
				expect(page.all('li')[2]).to have_content("State of #{@user_1.state}: 14 items shipped")

				expect(page).to_not have_content("State of #{@user_7.state}")
			end
		end

		it "top 3 city/state where my items were shipped, and their quantities" do
			within "#top-three-citystates-for-items-shipped" do
				expect(page.all('li')[0]).to have_content("City of #{@user_2.city}, #{@user_2.state}: 22 items shipped")
				expect(page.all('li')[1]).to have_content("City of #{@user_4.city}, #{@user_4.state}: 16 items shipped")
				expect(page.all('li')[2]).to have_content("City of #{@user_1.city}, #{@user_1.state}: 14 items shipped")

				expect(page).to_not have_content("City of #{@user_7.state}")
			end
		end

		it "name of the user with the most orders from me" do
			within "#top-user-by-orders" do
				expect(page).to have_content("#{@user_7.name}: 2 orders")
			end
		end

		it "name of the user who bought the most total items from me" do
			within "#top-user-by-items" do
				expect(page).to have_content("#{@user_1.name}: 14 items")
			end
		end

		it "top 3 users who have spent the most money on my items, and the total amount they've spent" do
			within "#top-three-users-by-spending" do
				expect(page.all('li')[0]).to have_content("#{@user_4.name}: $220.00")
				expect(page.all('li')[1]).to have_content("#{@user_1.name}: $35.00")
				expect(page.all('li')[2]).to have_content("#{@user_2.name}: $30.00")
			end
		end
	end
end
