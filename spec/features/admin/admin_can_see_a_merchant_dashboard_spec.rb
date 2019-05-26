require 'rails_helper'

RSpec.describe 'As an admin user on the merchant index page' do
	describe 'I click on the link to a merchant name' do
		it 'shows everything the merchant would see in a nested admin_merchant_show route' do
			visit(merchant_path(@merchant_1))

			within "#merchant-profile-info" do
				expect(page).to have_content("Name: #{merchant.name}")
				expect(page).to have_content("Email: #{merchant.email}")
				expect(page).to have_content("Address: #{merchant.address}")
				expect(page).to have_content("City: #{merchant.city}")
				expect(page).to have_content("State: #{merchant.state}")
				expect(page).to have_content("Zip Code: #{merchant.zip}")
			end

			expect(current_path).to eq(admin_merchant_show_path(@merchant_1))
		end
	end
end
