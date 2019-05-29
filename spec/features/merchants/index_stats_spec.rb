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

      @order_1 = create(:order, user: @buyer_1)
      @order_2 = create(:order, user: @buyer_2)
      @order_3 = create(:order, user: @buyer_3)
      @order_4 = create(:order, user: @buyer_4)

      @item_1 = @merchant_1.items.create!(name: "Item One",   active: true,  price: 1.00, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
      @item_2 = @merchant_2.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
      @item_3 = @merchant_3.items.create!(name: "Item Tres",  active: true,  price: 3.00, description: "This is item tres",  image: "https://picsum.photos/200/300?image=1", inventory: 300)
      @item_4 = @merchant_4.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)

      @order_item_1 = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 1, price: 1.00, fulfilled: true, updated_at: 1.days.ago, created_at: 2.days.ago)
      @order_item_2 = @item_2.order_items.create!(item: @item_2, order: @order_2, quantity: 2, price: 2.00, fulfilled: true, updated_at: 1.days.ago, created_at: 3.days.ago)
      @order_item_3 = @item_3.order_items.create!(item: @item_3, order: @order_3, quantity: 3, price: 3.00, fulfilled: true, updated_at: 1.days.ago, created_at: 4.days.ago)
      @order_item_4 = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 4.00, fulfilled: true, updated_at: 1.days.ago, created_at: 5.days.ago)
    end
    
    it "shows the top 3 merchants who have sold the most by price and quantity, and their revenue" do
      visit merchants_path

      within "#merchant-stats-box" do
        expect(page).to have_content("Most Sold: #{User.top_three_revenue}")
        expect(page).to have_content("Fastest Merchants: #{User.three_fastest}")
        expect(page).to have_content("Slowest Merchants: #{User.three_slowest}")
        expect(page).to have_content("States with most sales: #{User.top_three_states}")
        expect(page).to have_content("Cities with most sales: #{User.top_three_cities}")
        expect(page).to have_content("Largest Orders: #{Order.top_three_biggest_orders}")

      end

    end

  end
end

# As a visitor
# When I visit the merchants index page, I see an area with statistics:
# - top 3 merchants who have sold the most by price and quantity, and their revenue
# - top 3 merchants who were fastest at fulfilling items in an order, and their times
# - worst 3 merchants who were slowest at fulfilling items in an order, and their times
# - top 3 states where any orders were shipped (by number of orders), and count of orders
# - top 3 cities where any orders were shipped (by number of orders, also Springfield, MI should not be grouped with Springfield, CO), and the count of orders
# - top 3 biggest orders by quantity of items shipped in an order, plus their quantities
