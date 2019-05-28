require 'rails_helper'

RSpec.describe 'As any user' do
  describe 'when I visit an item show page' do
		before :each do
			@merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			@active_item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 100)
			@active_item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 200)

 			@inactive_item =  @merchant_1.items.create!(name: "this is a word", active: false, price: 2.00, description: "Buy things with your MONEY!", image: "fake url", inventory: 200)
		end

		it 'shows details about the item' do

			visit items_path

      within "#item-#{@active_item_1.id}" do
        click_link("#{@active_item_1.name}")
      end

      expect(current_path).to eq(item_path(@active_item_1))

  		expect(page).to have_content(@active_item_1.name)
  		expect(page).to have_content(@active_item_1.price)
  		expect(page).to have_css("img[src*='#{@active_item_1.image}']")
  		expect(page).to have_content(@active_item_1.user.name)
  		expect(page).to have_content(@active_item_1.inventory)

  		expect(page).to_not have_content(@inactive_item.name)
  		expect(page).to_not have_content(@active_item_2.name)
		end

    it 'shows the average amount of time it takes this merchant to fulfill this item' do

      merchant = User.create!(email: "seller@email.com", password: "password", role: 1, active: true, name: "Seller", address: "456 Seller Lane", city: "Sellermore", state: "SL", zip: "99999")

      item = merchant.items.create!(name: "Item 1", active: true, price: 1.00, description: "Buy things with your MONEY!", image: "https://bit.ly/2JH7Zl1", inventory: 100)

      buyer = User.create!(email: "buyer@email.com", password: "password", role: 0, active: true, name: "Buy Yer", address: "123 Buyer Lane", city: "Buya Buya", state: "BY", zip: "11111")

      order_1 = create(:order, user: buyer)
      order_2 = create(:order, user: buyer)
      order_3 = create(:order, user: buyer)

      @time_now = Time.now
      @time_plus_one = Time.now + 86400 # one day = 86400 seconds
      @time_plus_two = Time.now + 172800 # two days
      @time_plus_three = Time.now + 259200 # three days

      order_item = item.order_items.create!(item: item, order: order_1, quantity: 10, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_one)
      order_item_2 = item.order_items.create!(item: item, order: order_2, quantity: 20, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_two)
      order_item_3 = item.order_items.create!(item: item, order: order_3, quantity: 30, price: 5.00, fulfilled: true, created_at: @time_now, updated_at: @time_plus_three)


      visit items_path

      within "#item-#{item.id}" do
        click_link("#{item.name}")
      end

      expect(current_path).to eq(item_path(item))
save_and_open_page
      expect(page).to have_content("Average amount of time it takes this merchant to fulfill this item: #{item.average_time_to_fulfill} days")
    end

	end
end
