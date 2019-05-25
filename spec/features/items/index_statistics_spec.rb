require 'rails_helper'

RSpec.describe 'As a visitor on the items index page' do
	describe 'I see an area with the index page statistics' do
		before :each do
			@merchant_1 = User.create!(email: "123@123.123", password: "password", role: 1, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			@merchant_2 = User.create!(email: "321@321.321", password: "password", role: 1, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			@item_1 = @merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_2 = @merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_3 = @merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_4 = @merchant_2.items.create!(name: "name_4", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_5 = @merchant_2.items.create!(name: "name_5", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_6 = @merchant_2.items.create!(name: "name_6", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_7 = @merchant_2.items.create!(name: "name_7", active: false, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			@buyer_1 = create(:user)
      @order_1 = create(:order, user: @buyer_1)

			@order_item_1a = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 10, price: 5.00, fulfilled: true)
			@order_item_1b = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 10, price: 5.00, fulfilled: true)

			@order_item_2a = @item_2.order_items.create!(item: @item_1, order: @order_1, quantity: 9, price: 5.00, fulfilled: true)
			@order_item_2b = @item_2.order_items.create!(item: @item_1, order: @order_1, quantity: 9, price: 5.00, fulfilled: true)

			@order_item_3a = @item_3.order_items.create!(item: @item_1, order: @order_1, quantity: 8, price: 5.00, fulfilled: true)
			@order_item_3b = @item_3.order_items.create!(item: @item_1, order: @order_1, quantity: 8, price: 5.00, fulfilled: true)

			@order_item_4a = @item_4.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: true)
			@order_item_4b = @item_4.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: true)

			@order_item_5a = @item_5.order_items.create!(item: @item_1, order: @order_1, quantity: 3, price: 5.00, fulfilled: true)
			@order_item_5b = @item_5.order_items.create!(item: @item_1, order: @order_1, quantity: 3, price: 5.00, fulfilled: true)

			@order_item_6a = @item_6.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: true)
			@order_item_6b = @item_6.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: true)

			@order_item_7a = @item_7.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: false)
			@order_item_7b = @item_7.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: false)
		end

		it 'shows the top 5 least and most popular items bought, along with total purchased quantity' do
			visit items_path

			within "#most-popular-items" do
				expect(page).to have_content(@item_1.name)
				expect(page).to have_content(@item_2.name)
				expect(page).to have_content(@item_3.name)
				expect(page).to have_content(@item_4.name)
				expect(page).to have_content(@item_5.name)

				expect(page).to have_content(20)
				expect(page).to have_content(18)
				expect(page).to have_content(16)
				expect(page).to have_content(14)
				expect(page).to have_content(2)

				expect(page).to_not have_content(@item_6.name)
				expect(page).to_not have_content(@item_7.name)
			end

			within "#least-popular-items" do
				expect(page).to have_content(@item_2.name)
				expect(page).to have_content(@item_3.name)
				expect(page).to have_content(@item_4.name)
				expect(page).to have_content(@item_5.name)
				expect(page).to have_content(@item_6.name)

				expect(page).to have_content(2)
				expect(page).to have_content(6)
				expect(page).to have_content(14)
				expect(page).to have_content(16)
				expect(page).to have_content(18)

				expect(page).to_not have_content(@item_7.name)
				expect(page).to_not have_content(@item_1.name)
			end
		end
	end
end
