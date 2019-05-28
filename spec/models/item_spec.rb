require 'rails_helper'

describe Item, type: :model do
	describe 'relationships' do
		it {should belong_to :user}
		it {should have_many :order_items}
	end

	describe 'class methods' do
		it '.where_active' do

			merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			active_item = merchant_1.items.create!(name: "name", active: true, price: 2.20, description: "Buy things with your MONEY!", image: "fake url", inventory: 500)

			inactive_item = merchant_1.items.create!(name: "this is a word", active: false, price: 2.20, description: "Buy things with your MONEY!", image: "fake url", inventory: 500)

			expect(Item.where_active).to eq([active_item])
		end

		it '.top_5' do
			merchant_1 = User.create!(email: "123@123.123", password: "password", role: 1, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_4 = merchant_1.items.create!(name: "name_4", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_5 = merchant_1.items.create!(name: "name_5", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_6 = merchant_1.items.create!(name: "name_6", active: false, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			buyer_1 = create(:user)
      order_1 = create(:order, user: buyer_1)

			order_item_1 = item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			order_item_2 = item_2.order_items.create!(item: item_1, order: order_1, quantity: 9, price: 5.00, fulfilled: true)
			order_item_3 = item_3.order_items.create!(item: item_1, order: order_1, quantity: 8, price: 5.00, fulfilled: true)
			order_item_4 = item_4.order_items.create!(item: item_1, order: order_1, quantity: 7, price: 5.00, fulfilled: true)
			order_item_5 = item_5.order_items.create!(item: item_1, order: order_1, quantity: 6, price: 5.00, fulfilled: true)
			order_item_6 = item_6.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)

			expect(Item.top_5[0].name).to eq(item_1.name)
			expect(Item.top_5[0].sum).to eq(10)

			expect(Item.top_5[4].name).to eq(item_5.name)
			expect(Item.top_5[4].sum).to eq(6)

			expect(Item.top_5[5]).to eq(nil)
		end

		it '.bottom_5' do
			merchant_1 = User.create!(email: "123@123.123", password: "password", role: 1, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			item_1 = merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_2 = merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_3 = merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_4 = merchant_1.items.create!(name: "name_4", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_5 = merchant_1.items.create!(name: "name_5", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			item_6 = merchant_1.items.create!(name: "name_6", active: false, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			buyer_1 = create(:user)
      order_1 = create(:order, user: buyer_1)

			order_item_1 = item_1.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true)
			order_item_2 = item_2.order_items.create!(item: item_1, order: order_1, quantity: 9, price: 5.00, fulfilled: true)
			order_item_3 = item_3.order_items.create!(item: item_1, order: order_1, quantity: 8, price: 5.00, fulfilled: true)
			order_item_4 = item_4.order_items.create!(item: item_1, order: order_1, quantity: 7, price: 5.00, fulfilled: true)
			order_item_5 = item_5.order_items.create!(item: item_1, order: order_1, quantity: 6, price: 5.00, fulfilled: true)
			order_item_6 = item_6.order_items.create!(item: item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: false)

			expect(Item.bottom_5[0].name).to eq(item_5.name)
			expect(Item.bottom_5[0].sum).to eq(6)

			expect(Item.bottom_5[4].name).to eq(item_1.name)
			expect(Item.bottom_5[4].sum).to eq(10)

			expect(Item.bottom_5[5]).to eq(nil)
		end
	end

	describe "instance methods" do
		before :each do
			buyer = User.create!(email: "buyer@email.com", password: "password", role: 0, active: true, name: "Buy Yer", address: "123 Buyer Lane", city: "Buya Buya", state: "BY", zip: "11111")
			merchant_1 = User.create!(email: "seller_1@email.com", password: "password", role: 1, active: true, name: "Seller One", address: "111 Seller Lane", city: "Sellermore", state: "SL", zip: "11111")
			merchant_2 = User.create!(email: "seller_2@email.com", password: "password", role: 1, active: true, name: "Seller Two", address: "222 Seller Lane", city: "New Sellermore", state: "SL", zip: "22222")

			@item_1 = merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Buy things with your MONEY!", image: "https://bit.ly/2JH7Zl1", inventory: 100)
			@item_2 = merchant_2.items.create!(name: "Item 2", active: true, price: 2.00, description: "Buy things with your MONEY!", image: "https://bit.ly/2JH7Zl1", inventory: 200)

			order_1 = create(:order, user: buyer)
			order_2 = create(:order, user: buyer)
			order_3 = create(:order, user: buyer)
			order_4 = create(:order, user: buyer)

			@time_now = Time.now
			@time_plus_one = Time.now + 86400 # one day = 86400 seconds
			@time_plus_two = Time.now + 172800 # two days
			@time_plus_three = Time.now + 259200 # three days

			order_item_1 = @item_1.order_items.create!(item: @item_1, order: order_1, quantity: 10, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_one)
			order_item_2 = @item_1.order_items.create!(item: @item_1, order: order_2, quantity: 20, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_two)
			order_item_3 = @item_1.order_items.create!(item: @item_1, order: order_3, quantity: 30, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_three)
			order_item_4 = @item_2.order_items.create!(item: @item_2, order: order_4, quantity: 40, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_three)
		end

		it "returns average time for merchant to fulfill item" do
			expect(@item_1.average_time_to_fulfill).to eq(2.00)
		end
	end

end
