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

		it "counts quantity of a specific item in the order" do
			expect(@order_1.item_quantity(@item_1.id)).to eq(2)
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
end
