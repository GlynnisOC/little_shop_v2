require 'rails_helper'

RSpec.describe Order, type: :model do
	describe 'relationships' do
		it {should have_many :order_items}
		it {should have_many(:items).through(:order_items)}
		it {should belong_to(:user)}
	end

	describe 'instance methods' do
		before :each do
			@user_1 = User.create!(email: "123@123.123", password: "password", role: 0, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			@merchant_1 = User.create!(email: "456@123.123", password: "password", role: 1, active: true, name: "Rob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			@item_1 = @merchant_1.items.create!(name: "name_1", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_2 = @merchant_1.items.create!(name: "name_2", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )
			@item_3 = @merchant_1.items.create!(name: "name_3", active: true, price: 5.00, description: "does things n stuff", image: "https://www.kiplinger.com/kipimages/pages/18048.jpg", inventory: 100 )

			@order_1 = @user_1.orders.create!(status: "pending")
			@order_2 = @user_1.orders.create!(status: "pending")
			@order_3 = @user_1.orders.create!(status: "packaged")

			@item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: true)
			@item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 5.00, fulfilled: true)
			@item_2.order_items.create!(item: @item_2, order: @order_1, quantity: 1, price: 5.00, fulfilled: true)
			@item_1.order_items.create!(item: @item_1, order: @order_2, quantity: 10, price: 5.00, fulfilled: true)
			@item_1.order_items.create!(item: @item_1, order: @order_2, quantity: 10, price: 5.00, fulfilled: true)
			@item_3.order_items.create!(item: @item_3, order: @order_2, quantity: 10, price: 5.00, fulfilled: true)
		end

		it "#order_grand_total" do
			expect(@order_1.order_grand_total).to eq(15)
		end

		it "#total_items_in_order" do
			expect(@order_1.total_items_in_order).to eq(3)
			expect(@order_2.total_items_in_order).to eq(30)
		end

		it "#total_value_in_order" do
			expect(@order_1.total_value_in_order).to eq(15)
		end

		it "counts quantity of a specific item in the order" do
			expect(@order_1.item_quantity(@item_1.id)).to eq(2)
		end

		it "can 'ship' a packaged order" do
			expect(@order_3.status).to eq("packaged")
			@order_3.ship_packaged_order
			expect(@order_3.status).to eq("shipped")
		end

		it "can 'cancel' a pending order" do
			expect(@order_1.status).to eq("pending")
			@order_1.cancel_pending_order
			expect(@order_1.status).to eq("cancelled")
		end
	end

	describe "class methods" do
		it ".status_sorted" do
			order = create(:order)
			order2 = create(:packaged_order)
			order3 = create(:shipped_order)
			order4 = create(:cancelled_order)

			expect(Order.status_sorted).to eq([order, order2, order3, order4])
		end
	end

	describe "merchant statistics methods" do
		before :each do
			@merchant_1 = create(:merchant)
			@merchant_2 = create(:merchant)
			@merchant_3 = create(:merchant)
			@merchant_4 = create(:merchant)

			@buyer_1 = User.create!(email: "buyer_1@email.com", 	password: "password", role: "default",  name: "buyer_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 11111)
			@buyer_2 = User.create!(email: "buyer_2@email.com", 	password: "password", role: "default",  name: "buyer_name_2", address: "2000 Abc Street", city: "City_2", state: "BB", zip: 22222)
			@buyer_3 = User.create!(email: "buyer_3@email.com", 	password: "password", role: "default",  name: "buyer_name_3", address: "3000 Abc Street", city: "City_3", state: "CC", zip: 33333)
			@buyer_4 = User.create!(email: "buyer_4@email.com", 	password: "password", role: "default",  name: "buyer_name_4", address: "4000 Abc Street", city: "City_4", state: "DD", zip: 44444)

			@order_1a = create(:shipped_order, user: @buyer_1)

			@order_2a = create(:shipped_order, user: @buyer_2)
			@order_2b = create(:shipped_order, user: @buyer_2)

			@order_3a = create(:shipped_order, user: @buyer_3)
			@order_3b = create(:shipped_order, user: @buyer_3)
			@order_3c = create(:shipped_order, user: @buyer_3)

			@order_4a = create(:shipped_order, user: @buyer_4)
			@order_4b = create(:shipped_order, user: @buyer_4)
			@order_4c = create(:shipped_order, user: @buyer_4)
			@order_4d = create(:shipped_order, user: @buyer_4)

			@item_1 = @merchant_1.items.create!(name: "Item One",   active: true,  price: 1.00, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
			@item_2 = @merchant_2.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
			@item_3 = @merchant_3.items.create!(name: "Item Tres",  active: true,  price: 3.00, description: "This is item tres",  image: "https://picsum.photos/200/300?image=1", inventory: 300)
			@item_4 = @merchant_4.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)

			@order_item_1a = @item_1.order_items.create!(item: @item_1, order: @order_1a, quantity: 1, price: 1.00, fulfilled: true, updated_at: 1.days.ago, created_at: 2.days.ago)

			@order_item_2a = @item_2.order_items.create!(item: @item_2, order: @order_2a, quantity: 2, price: 2.00, fulfilled: true, updated_at: 1.days.ago, created_at: 3.days.ago)
			@order_item_2b = @item_2.order_items.create!(item: @item_2, order: @order_2b, quantity: 2, price: 2.00, fulfilled: true, updated_at: 1.days.ago, created_at: 3.days.ago)

			@order_item_3a = @item_3.order_items.create!(item: @item_3, order: @order_3a, quantity: 3, price: 3.00, fulfilled: true, updated_at: 1.days.ago, created_at: 4.days.ago)
			@order_item_3b = @item_3.order_items.create!(item: @item_3, order: @order_3b, quantity: 3, price: 3.00, fulfilled: true, updated_at: 1.days.ago, created_at: 4.days.ago)
			@order_item_3c = @item_3.order_items.create!(item: @item_3, order: @order_3c, quantity: 3, price: 3.00, fulfilled: true, updated_at: 1.days.ago, created_at: 4.days.ago)

			@order_item_4a = @item_4.order_items.create!(item: @item_4, order: @order_4a, quantity: 4, price: 4.00, fulfilled: true, updated_at: 1.days.ago, created_at: 5.days.ago)
			@order_item_4b = @item_4.order_items.create!(item: @item_4, order: @order_4b, quantity: 8, price: 4.00, fulfilled: true, updated_at: 1.days.ago, created_at: 5.days.ago)
			@order_item_4c = @item_4.order_items.create!(item: @item_4, order: @order_4c, quantity: 9, price: 4.00, fulfilled: true, updated_at: 1.days.ago, created_at: 5.days.ago)
			@order_item_4d = @item_4.order_items.create!(item: @item_4, order: @order_4d, quantity: 10, price: 4.00, fulfilled: true, updated_at: 1.days.ago, created_at: 5.days.ago)
		end

		it ".largest_orders" do
			expect(Order.largest_orders).to eq([@order_4d, @order_4c, @order_4b])
		end

	end
end
