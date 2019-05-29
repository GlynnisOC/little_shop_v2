require 'rails_helper'

RSpec.describe "As a visitor on the merchant index page" do
  describe "I see an area with statistics" do
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

    it "shows the top 3 merchants who have sold the most by price and quantity, and their revenue" do
      visit merchants_path

      within "#top-three-revenue" do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_2.name)

        @merchants = User.top_three_revenue
        expect(page).to have_content(@merchants[0].revenue)
        expect(page).to have_content(@merchants[1].revenue)
        expect(page).to have_content(@merchants[2].revenue)
      end

      within "#fastest-merchants" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)

        @merchants = User.fastest_merchants
        expect(page).to have_content(@merchants[0].speed)
        expect(page).to have_content(@merchants[1].speed)
        expect(page).to have_content(@merchants[2].speed)
      end

      within "#slowest-merchants" do
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_2.name)

        @merchants = User.slowest_merchants
        expect(page).to have_content(@merchants[0].speed)
        expect(page).to have_content(@merchants[1].speed)
        expect(page).to have_content(@merchants[2].speed)
      end

      within "#most-popular-states" do
        expect(page).to have_content(@buyer_4.state)
        expect(page).to have_content(@buyer_3.state)
        expect(page).to have_content(@buyer_2.state)

        @buyers = User.most_popular_states
        expect(page).to have_content(@buyers[0].order_count)
        expect(page).to have_content(@buyers[1].order_count)
        expect(page).to have_content(@buyers[2].order_count)
      end

      within "#most-popular-cities" do
        expect(page).to have_content(@buyer_4.city)
        expect(page).to have_content(@buyer_3.city)
        expect(page).to have_content(@buyer_2.city)

        @buyers = User.most_popular_cities
        expect(page).to have_content(@buyers[0].order_count)
        expect(page).to have_content(@buyers[1].order_count)
        expect(page).to have_content(@buyers[2].order_count)
      end

      within "#largest-orders" do
        expect(page).to have_content(@order_item_4d.quantity)
        expect(page).to have_content(@order_item_4c.quantity)
        expect(page).to have_content(@order_item_4b.quantity)
      end
    end
  end
end

# - top 3 cities where any orders were shipped (by number of orders,
# also Springfield, MI should not be grouped with Springfield, CO)
