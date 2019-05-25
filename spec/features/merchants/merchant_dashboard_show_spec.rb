require 'rails_helper'

RSpec.describe 'As a registered merchant on the site' do
	describe 'when I visit my dashboard' do
		it 'shows my data and I cannot edit it' do
			merchant = User.create!(email: "jimbob@bob.bob", password: "password", role: "merchant", name: "jimbob", address: "321 blastoff st", city: "Big Greasy Easy", state: "LA", zip: 38511)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

			visit dashboard_path

			within "#merchant-profile-info" do
				expect(page).to have_content("Name: #{merchant.name}")
				expect(page).to have_content("Email: #{merchant.email}")
				expect(page).to have_content("Address: #{merchant.address}")
				expect(page).to have_content("City: #{merchant.city}")
				expect(page).to have_content("State: #{merchant.state}")
				expect(page).to have_content("Zip Code: #{merchant.zip}")
			end
		end
	end

	describe "When I visit my items page '/dashboard/items'" do
		before :each do
			merchant = User.create!(email: "merchant@email.com", password: "password", role: "merchant", name: "Murr Chante", address: "123 Sesame St", city: "Merchantsville", state: "MV", zip: 38511)

			visit login_path

			fill_in "Email", with:  "merchant@email.com"
			fill_in "Password", with: "password"
			click_button("Login")
		end
		it "I see a link to add a new item to the system" do
			visit dashboard_items_path

			expect(page).to have_link("Add new item")
			
		end
	end

	# I see a link to add a new item to the system
	# I see each item I have already added to the system, including:
	# - the ID of the item
	# - the name of the item
	# - a thumbnail image for that item
	# - the price of that item
	# - my current inventory count for that item
	# - a link or button to edit the item
	#
	# If no user has ever ordered this item, I see a link to delete the item
	# If the item is enabled, I see a button or link to disable the item
	# If the item is disabled, I see a button or link to enable the item


end
