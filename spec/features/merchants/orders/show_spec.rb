require 'rails_helper'

describe "As a merchant" do
  describe "when I visit an order show page from my dashboard" do
    before :each do
      @merchant_1 = User.create!(email: "merchant_1@email.com", password: "password", role: "merchant", name: "Murr Chante Sr", address: "123 Sesame St", city: "Merchantsville",   state: "MV", zip: 38511)
			@merchant_2 =  User.create!(email: "merchant_2@email.com", password: "password", role: "merchant", name: "Mrs Chante",     address: "123 Sesame St", city: "New Merchantston", state: "MV", zip: 38511)

			@buyer_1 = User.create!(email: "buyer_1@email.com", 	password: "password", role: "default",  name: "buyer_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 00001)
			@buyer_2 = User.create!(email: "buyer_2@email.com", 	password: "password", role: "default",  name: "buyer_name_2", address: "2000 Abc Street", city: "City_1", state: "AB", zip: 00002)
			@buyer_3 = User.create!(email: "buyer_3@email.com", 	password: "password", role: "default",  name: "buyer_name_3", address: "3000 Abc Street", city: "City_1", state: "AB", zip: 00003)

      @item_1 = @merchant_1.items.create!(name: "Item One",   active: true,  price: 1.11, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
      @item_3 = @merchant_1.items.create!(name: "Item Tres",  active: true,  price: 3.33, description: "This is item tres",  image: "https://picsum.photos/200/300?image=1", inventory: 300)
      @item_5 = @merchant_1.items.create!(name: "Item Five", 	active: true,  price: 5.55, description: "This is item five",  image: "https://picsum.photos/200/300?image=1", inventory: 500)

			@item_2 = @merchant_2.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
			@item_4 = @merchant_2.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)
      @item_6 = @merchant_2.items.create!(name: "Item Six", 	active: true,  price: 6.00, description: "This is item six", 	 image: "https://picsum.photos/200/300?image=1", inventory: 600)

      @order_1 = @buyer_1.orders.create(status: 0)
      @order_2 = @buyer_2.orders.create(status: 0)
      # @order_3 = @buyer_3.orders.create(status: 0)

      @order_item_1_1 = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 11, price: 1.00, fulfilled: false)
      @order_item_1_2 = @item_2.order_items.create!(item: @item_2, order: @order_1, quantity: 22, price: 2.00, fulfilled: false)
      @order_item_1_3 = @item_3.order_items.create!(item: @item_3, order: @order_1, quantity: 33, price: 3.00, fulfilled: false)

      @order_item_2_3 = @item_3.order_items.create!(item: @item_3, order: @order_2, quantity: 2, price: 3.00, fulfilled: false)
      @order_item_2_4 = @item_4.order_items.create!(item: @item_4, order: @order_2, quantity: 2, price: 4.00, fulfilled: false)
      #
      # @order_item_3_5 = @item_5.order_items.create!(item: @item_5, order: @order_3, quantity: 3, price: 5.00, fulfilled: false)
      # @order_item_3_6 = @item_6.order_items.create!(item: @item_6, order: @order_3, quantity: 3, price: 6.00, fulfilled: false)

    end

    it "routes to the correct path" do

      visit login_path

      fill_in "Email", with:  "merchant_1@email.com"
      fill_in "Password", with: "password"
      click_button("Login")

      visit dashboard_order_path(@order_1.id)

      expect(page).to have_content(@buyer_1.name)
      expect(page).to have_content(@buyer_1.address)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@order_item_1_1.price)
      expect(page).to have_content(@order_item_1_1.quantity)
      
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@order_item_1_3.price)
      expect(page).to have_content(@order_item_1_3.quantity)

    end
  end
end
