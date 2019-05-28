require 'rails_helper'

RSpec.describe 'As a registered merchant on my dashboard page' do
	describe 'I see a link to view my own items' do
		it 'takes me to /dashboard/items' do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

			visit dashboard_path

			click_link "View My Items"

			expect(current_path).to eq(dashboard_items_path)
		end

		it 'from the items link, I can disable enabled items' do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)
			item_1 = merchant_1.items.create!(name: "Item One", active: true, price: 1.00, description: "This is item one", image: "https://picsum.photos/200/300?image=1", inventory: 100)

			visit dashboard_items_path

			within "#merchant-item-#{item_1.id}" do
				expect(item_1.active).to be_truthy
				click_button "Disable"
				item_1.reload
				expect(item_1.active).to be_falsey
			end
			expect(page).to have_content("#{item_1.name} is no longer for sale")
			expect(current_path).to eq(dashboard_items_path)
		end

		it 'from the items link, I can enable disabled items' do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)
			item_1 = merchant_1.items.create!(name: "Item One", active: false, price: 1.00, description: "This is item one", image: "https://picsum.photos/200/300?image=1", inventory: 100)

			visit dashboard_items_path

			within "#merchant-item-#{item_1.id}" do
				expect(item_1.active).to be_falsey
				click_button "Enable"
				item_1.reload
				expect(item_1.active).to be_truthy
			end
			expect(page).to have_content("#{item_1.name} is now available for sale")
			expect(current_path).to eq(dashboard_items_path)

		end
	end
end
