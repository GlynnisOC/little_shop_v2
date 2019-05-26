require 'rails_helper'

RSpec.describe 'As a registered user' do
	describe 'I see my profile data' do
		it 'shows all info excluding password, and a link to edit the info' do
			user = User.create!(email: "joebob@jimbob.bobbob", password: "password", name: "joebob", address: "123 street", city: "Atlantis", state:"I am the cosmic state of affairs", zip: "80211")

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit profile_path

			within "#user-profile-info" do
				expect(page).to have_content("Name: #{user.name}")
				expect(page).to have_content("Email: #{user.email}")
				expect(page).to have_content("Address: #{user.address}")
				expect(page).to have_content("City: #{user.city}")
				expect(page).to have_content("State: #{user.state}")
				expect(page).to have_content("Zip Code: #{user.zip}")
			end
		end

		it 'my profile page shows "My Orders" link when there orders' do
			user_1 = User.create!(email: "123@123.123", password: "password", role: 0, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
			User.create!(email: "456@123.123", password: "password", role: 1, active: true, name: "Rob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			visit profile_path
			expect(page).to_not have_content("My Orders")

			user_1.orders.create!(status: 0)

			visit profile_path
			expect(page).to have_link("My Orders")
			click_link("My Orders")

			expect(current_path).to eq(profile_orders_path)
		end

		it '"My Order" links to order index page' do
			user_1 = User.create!(email: "123@123.123", password: "password", role: 0, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
			merchant_1 = User.create!(email: "456@123.123", password: "password", role: 1, active: true, name: "Rob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			order_1 = user_1.orders.create!(status: "pending")
			order_2 = user_1.orders.create!(status: "pending")

			item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_2.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_2, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_2, quantity: 10, price: 5.00, fulfilled: true)
			item_3.order_items.create!(item: item_2, order: order_2, quantity: 10, price: 5.00, fulfilled: true)

			visit profile_path
			click_link("My Orders")
			expect(current_path).to eq(profile_orders_path)

			within "#orders-index-order-#{order_1.id}" do
				expect(page).to have_link("#{order_1.id}")
				expect(page).to have_content(order_1.created_at.strftime("%F"))
				expect(page).to have_content(order_1.updated_at.strftime("%F"))
				expect(page).to have_content(order_1.status)
				expect(page).to have_content(order_1.items.length)
				expect(page).to have_content(order_1.order_grand_total)
			end
		end

		it 'Order Index page has link to Order Show Page' do
			user_1 = User.create!(email: "123@123.123", password: "password", role: 0, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
			merchant_1 = User.create!(email: "456@123.123", password: "password", role: 1, active: true, name: "Rob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			order_1 = user_1.orders.create!(status: "pending")
			order_2 = user_1.orders.create!(status: "pending")

			item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_2.order_items.create!(item: item_2, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_2, quantity: 10, price: 5.00, fulfilled: true)
			item_1.order_items.create!(item: item_1, order: order_2, quantity: 10, price: 5.00, fulfilled: true)
			item_3.order_items.create!(item: item_2, order: order_2, quantity: 10, price: 5.00, fulfilled: true)

			visit profile_path
			click_link("My Orders")

			within "#orders-index-order-#{order_1.id}" do
				click_link("#{order_1.id}")
			end

			expect(current_path).to eq("/profile/orders/#{order_1.id}")

			expect(page).to have_content(order_1.id)
			expect(page).to have_content(order_1.created_at.strftime("%F"))
			expect(page).to have_content(order_1.updated_at.strftime("%F"))
			expect(page).to have_content(order_1.status)

			within "#order-show-item-#{item_1.id}" do
				expect(page).to have_content(item_1.name)
				expect(page).to have_content(item_1.description)
				expect(page).to have_xpath("//img[contains(@src,'#{item_1.image}')]")
				expect(page).to have_content("Item Quantity: 2")
				expect(page).to have_content(item_1.price)
				expect(page).to have_content("Item Subtotal: $10.00")
			end
			
			expect(page).to have_content("Total Items in Order: #{order_1.items.size}")
			expect(page).to have_content(order_1.order_grand_total)
		end
	end
end
