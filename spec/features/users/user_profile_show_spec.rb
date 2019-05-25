require 'rails_helper'

RSpec.describe 'As a registered user' do
	describe 'I see my profile data' do
		it 'shows all info excluding password, and a link to edit the info' do
			user = User.create!(email: "joebob@jimbob.bobbob", password: "password", name: "joebob", address: "123 street", city: "Atlantis", state:"I am the cosmic state of affairs", zip: "80211")

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit profile_path

			within "#user-profile-info" do
				expect(page).to have_content("Name: #{user.name}")
				expect(page).to have_content("Email: #{user.email}")
				expect(page).to have_content("Address: #{user.address}")
				expect(page).to have_content("City: #{user.city}")
				expect(page).to have_content("State: #{user.state}")
				expect(page).to have_content("Zip Code: #{user.zip}")
			end
		end

		it 'my profile page shows "My Orders" link when there orders' do
			user_1 = User.create!(email: "123@123.123", password: "password", role: 0, active: true, name: "Bob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

			merchant_1 = User.create!(email: "456@123.123", password: "password", role: 1, active: true, name: "Rob", address: "123 shady lane", city: "Memphis", state: "TN", zip: 80315)

			visit profile_path

			expect(page).to_not have_content("My Orders")

			# @order_1 = create(:order, user: @user)
			order_1 = user_1.orders.create!(status: 0)



			# expect(page).to have_link("My Orders")
			# click_link("My Orders")
			#
			# expect(current_path).to eq("/profile/orders")

		end
	end
end
