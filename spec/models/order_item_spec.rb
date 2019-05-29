require 'rails_helper'

RSpec.describe OrderItem, type: :model do
	describe 'relationships' do
		it {should belong_to :item}
		# it {should belong_to :order}
	end


	describe "instance methods" do

		before :each do
			@merchant_1 =  User.create!(email: "merchant_2@email.com", password: "password", role: "merchant", name: "Mrs Chante",     address: "123 Sesame St", city: "New Merchantston", state: "MV", zip: 38511)

			@buyer_1 = User.create!(email: "buyer_1@email.com", 	password: "password", role: "default",  name: "buyer_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 00001)

			@item_1 = @merchant_1.items.create!(name: "Item One",   active: true,  price: 1.11, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)

			@order_1 = @buyer_1.orders.create(status: 0)

			@order_item_1_1 = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 11, price: 1.00, fulfilled: false)
		end

		it "#item_name" do
			expect(@order_item_1_1.item_name).to eq(@item_1.name)
		end
		
		it "#item_image" do
			expect(@order_item_1_1.item_image).to eq(@item_1.image)
		end

	end
end
