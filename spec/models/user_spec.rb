require 'rails_helper'

RSpec.describe User, type: :model do
	before :each do
      @merchant_1 = User.create!(email: "@merchant_1@gmail.com", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      @merchant_2 = create(:merchant)
      @inactive_merchant = create(:inactive_merchant)
      @admin_1 = User.create!(email: "@admin_1@gmail.com", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")


      @user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      @user_2 = create(:inactive_user)
	end

  describe 'relationships' do
		it {should have_many :items}
  end

	describe 'validations' do
		it {should validate_presence_of :email}
		it {should validate_uniqueness_of :email}
		it {should validate_presence_of :password}
		it {should validate_presence_of :role}
		it {should validate_presence_of :address}
		it {should validate_presence_of :city}
		it {should validate_presence_of :state}
		it {should validate_presence_of :zip}
	end

  describe 'roles' do
    it "can be created as a merchant" do

      expect(@merchant_1.role).to eq("merchant")
      expect(@merchant_1.merchant?).to be_truthy
    end

    it "can be created as an admin" do

      expect(@admin_1.role).to eq("admin")
      expect(@admin_1.admin?).to be_truthy
    end

    it "can be created as a default user" do

      expect(@user_1.role).to eq("default")
      expect(@user_1.default?).to be_truthy
    end
  end

	describe 'instance methods' do
		it '#upgrade_to_merchant' do
			user = create(:user)
			user.upgrade_to_merchant
			user.reload
			expect(user.role).to eq("merchant")
		end

		it '#downgrade_to_user' do
		  merchant = create(:merchant)
			merchant.downgrade_to_user
			expect(merchant.role).to eq("default")
		end

		it '#enable_merchant' do
      inactive_merchant = create(:inactive_merchant)
			inactive_merchant.enable_merchant
			inactive_merchant.reload
			expect(inactive_merchant.active).to be_truthy
		end

		it '#disable_merchant' do
			merchant = create(:merchant)
			merchant.disable_merchant
			merchant.reload
			expect(merchant.active).to be_falsy
		end

		it '#item_disable' do
			merchant = create(:merchant)
			item_1 = create(:item, user: merchant)
			item_2 = create(:item, user: merchant)
			merchant.item_disable
			item_1.reload
			item_2.reload
			expect(item_1.active).to be_falsey
			expect(item_2.active).to be_falsey
		end
	end

  describe 'class methods' do
    it ".email_taken" do
      User.create(name: "Bobby", email: "aol@gmail.com", password: "password", address: "123 6th ave", city: "Denver", state: "Colorado", zip: "80226")
      email = "aol@gmail.com"

      expect(User.email_taken(email)).to be_truthy
    end

		it '.all_reg_users' do
			expect(User.all_reg_users).to eq([@user_1, @user_2])
		end

		it '.active_merchants' do
			actual = User.active_merchants
			expect(actual).to eq([@merchant_1, @merchant_2])
		end

		it '.all_merchants' do
			expect(User.all_merchants).to eq([@merchant_1, @merchant_2, @inactive_merchant])
		end
  end
end

describe 'merchant dashboard stats methods' do
	before :each do
		@merchant = User.create!(email: "merchant@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)
		@user_1		= User.create!(email: "user_1@email.com", 	password: "password", role: "default",  name: "user_name_1", address: "1000 Abc Street", city: "City_1", state: "AA", zip: 00001)
		@user_2		= User.create!(email: "user_2@email.com", 	password: "password", role: "default",  name: "user_name_2", address: "2000 Abc Street", city: "City_1", state: "AB", zip: 00002)
		@user_3		= User.create!(email: "user_3@email.com", 	password: "password", role: "default",  name: "user_name_3", address: "3000 Abc Street", city: "City_1", state: "AB", zip: 00003)
		@user_4 	= User.create!(email: "user_4@email.com", 	password: "password", role: "default",  name: "user_name_4", address: "4000 Abc Street", city: "City_1", state: "AC", zip: 00004)
		@user_5 	= User.create!(email: "user_5@email.com", 	password: "password", role: "default",  name: "user_name_5", address: "5000 Abc Street", city: "City_1", state: "AC", zip: 00004)
		@user_6 	= User.create!(email: "user_6@email.com", 	password: "password", role: "default",  name: "user_name_6", address: "6000 Abc Street", city: "City_1", state: "AC", zip: 00004)
		@user_7 	= User.create!(email: "user_7@email.com", 	password: "password", role: "default",  name: "user_name_7", address: "7000 Abc Street", city: "City_1", state: "AD", zip: 00004)

		@item_1 = @merchant.items.create!(name: "Item One", 	active: true,  price: 1.00, description: "This is item one", 	 image: "https://picsum.photos/200/300?image=1", inventory: 100)
		@item_2 = @merchant.items.create!(name: "Item Two", 	active: true,  price: 2.00, description: "This is item two", 	 image: "https://picsum.photos/200/300?image=1", inventory: 200)
		@item_3 = @merchant.items.create!(name: "Item Three", active: true,  price: 3.00, description: "This is item three", image: "https://picsum.photos/200/300?image=1", inventory: 300)
		@item_4 = @merchant.items.create!(name: "Item Four", 	active: true,  price: 4.00, description: "This is item four",  image: "https://picsum.photos/200/300?image=1", inventory: 400)
		@item_5 = @merchant.items.create!(name: "Item Five", 	active: true,  price: 5.00, description: "This is item five",  image: "https://picsum.photos/200/300?image=1", inventory: 500)
		@item_6 = @merchant.items.create!(name: "Item Six", 	active: true,  price: 6.00, description: "This is item six", 	 image: "https://picsum.photos/200/300?image=1", inventory: 600)
		@item_7 = @merchant.items.create!(name: "Item Seven",	active: true,  price: 6.00, description: "This is item seven", image: "https://picsum.photos/200/300?image=1", inventory: 700)

		@order_1 = @user_1.orders.create(status: 2)
		@order_2 = @user_2.orders.create(status: 2)
		@order_3 = @user_3.orders.create(status: 2)
		@order_4 = @user_4.orders.create(status: 2)
		@order_5 = @user_5.orders.create(status: 2)
		@order_6 = @user_6.orders.create(status: 2)
		@order_7 = @user_7.orders.create(status: 2)
		@order_8 = @user_7.orders.create(status: 2)

		@order_item_1a = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: true)
		@order_item_1b = @item_1.order_items.create!(item: @item_1, order: @order_1, quantity: 7, price: 5.00, fulfilled: false)

		@order_item_2a = @item_2.order_items.create!(item: @item_2, order: @order_2, quantity: 6, price: 5.00, fulfilled: true)
		@order_item_2b = @item_2.order_items.create!(item: @item_2, order: @order_2, quantity: 6, price: 5.00, fulfilled: false)

		@order_item_3a = @item_3.order_items.create!(item: @item_3, order: @order_3, quantity: 5, price: 5.00, fulfilled: true)
		@order_item_3b = @item_3.order_items.create!(item: @item_3, order: @order_3, quantity: 5, price: 5.00, fulfilled: false)

		@order_item_4a = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 55.00, fulfilled: true)
		@order_item_4b = @item_4.order_items.create!(item: @item_4, order: @order_4, quantity: 4, price: 55.00, fulfilled: false)

		@order_item_5a = @item_5.order_items.create!(item: @item_5, order: @order_5, quantity: 3, price: 5.00, fulfilled: true)
		@order_item_5b = @item_5.order_items.create!(item: @item_5, order: @order_5, quantity: 3, price: 5.00, fulfilled: false)

		@order_item_6a = @item_6.order_items.create!(item: @item_6, order: @order_6, quantity: 1, price: 5.00, fulfilled: true)
		@order_item_6b = @item_6.order_items.create!(item: @item_6, order: @order_6, quantity: 1, price: 5.00, fulfilled: false)

		@order_item_7a = @item_7.order_items.create!(item: @item_7, order: @order_7, quantity: 1, price: 5.00, fulfilled: true)
		@order_item_7b = @item_7.order_items.create!(item: @item_7, order: @order_7, quantity: 1, price: 5.00, fulfilled: false)

		@order_item_8a = @item_7.order_items.create!(item: @item_7, order: @order_8, quantity: 1, price: 5.00, fulfilled: true)
		@order_item_8b = @item_7.order_items.create!(item: @item_7, order: @order_8, quantity: 1, price: 5.00, fulfilled: false)
	end

	it "produces top five items sold by quantity" do
		expect(@merchant.top_five_items_sold.length).to eq(5)
		expect(@merchant.top_five_items_sold.first.name).to eq(@item_1.name)
		expect(@merchant.top_five_items_sold.first.item_quantity).to eq(7)
		expect(@merchant.top_five_items_sold.last.name).to eq(@item_5.name)
		expect(@merchant.top_five_items_sold.last.item_quantity).to eq(3)
	end

	it "calculates all items sold" do
		expect(@merchant.all_items_sold).to eq(28)
	end

	it "calculates total starting inventory" do
		expect(@merchant.total_starting_inventory).to eq(2800)
	end

	it "produces top three states for items shipped" do
		expect(@merchant.top_three_states.length).to eq(3)
		expect(@merchant.top_three_states.first.state).to eq("AB")
		expect(@merchant.top_three_states.second.state).to eq("AC")
		expect(@merchant.top_three_states.last.state).to eq("AA")
	end

	it "produces top three citystates for items shipped" do
		expect(@merchant.top_three_citystates.length).to eq(3)
		expect(@merchant.top_three_citystates.first.citystate).to eq("City_1, AB")
		expect(@merchant.top_three_citystates.second.citystate).to eq("City_1, AC")
		expect(@merchant.top_three_citystates.last.citystate).to eq("City_1, AA")
	end

	it "produces name of user with most orders, along with number of orders" do
		expect(@merchant.top_user_by_orders.name).to eq("#{@user_7.name}")
		expect(@merchant.top_user_by_orders.orders.length).to eq(2)
	end

	it "produces name of user with most items, along with number of items" do
		expect(@merchant.top_user_by_items[:user_name]).to eq("#{@user_1.name}")
		expect(@merchant.top_user_by_items[:unique_items]).to eq(14)
	end

	it "produces name of user with most spending, along with total spent" do
		expect(@merchant.top_three_users_by_spending.keys).to eq([@user_4.name, @user_1.name, @user_2.name])
		expect(@merchant.top_three_users_by_spending.values).to eq([220, 35, 30])
	end
end

describe "merchant index stats methods" do
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

	it ".top_three_revenue" do
		expect(User.top_three_revenue).to eq([@merchant_4, @merchant_3, @merchant_2])
	end

	it ".fastest_merchants" do
		expect(User.fastest_merchants).to eq([@merchant_1, @merchant_2, @merchant_3])
	end

	it ".slowest_merchants" do
		expect(User.slowest_merchants).to eq([@merchant_4, @merchant_3, @merchant_2])
	end

	it ".most_popular_states" do
		expect(User.most_popular_states[0].state).to eq(@buyer_4.state)
		expect(User.most_popular_states[1].state).to eq(@buyer_3.state)
		expect(User.most_popular_states[2].state).to eq(@buyer_2.state)

		expect(User.most_popular_states[0].order_count).to eq(4)
		expect(User.most_popular_states[1].order_count).to eq(3)
		expect(User.most_popular_states[2].order_count).to eq(2)
	end

	it ".most_popular_cities" do
		expect(User.most_popular_cities[0].city).to eq(@buyer_4.city)
		expect(User.most_popular_cities[1].city).to eq(@buyer_3.city)
		expect(User.most_popular_cities[2].city).to eq(@buyer_2.city)

		expect(User.most_popular_cities[0].order_count).to eq(4)
		expect(User.most_popular_cities[1].order_count).to eq(3)
		expect(User.most_popular_cities[2].order_count).to eq(2)
	end

end
