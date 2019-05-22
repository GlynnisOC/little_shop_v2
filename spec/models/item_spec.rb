require 'rails_helper'

describe Item, type: :model do
	describe 'relationships' do
		it {should belong_to :user}
	end

	describe 'class methods' do
		it '.where_active' do

			merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			@active_item = merchant_1.items.create!(name: "name", active: true, price: 2.20, description: "Buy things with your MONEY!", image: "fake url", inventory: 500)

			@inactive_item = merchant_1.items.create!(name: "this is a word", active: false, price: 2.20, description: "Buy things with your MONEY!", image: "fake url", inventory: 500)

			expect(Item.where_active).to eq([@active_item])
		end
	end
end
