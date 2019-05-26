require 'rails_helper'

RSpec.describe 'As an admin user on the merchant index page' do
	describe 'I click on the link to a merchant name' do
		before :each do
			@admin_1 = create(:admin)
			@merchant_1 = create(:merchant)
		end

	it 'shows everything the merchant would see in a nested admin_merchant_show route' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)

			visit(merchants_path)

			click_link(@merchant_1.name)

			expect(current_path).to eq(admin_merchant_path(@merchant_1))

			within "#merchant-#{@merchant_1.id}-profile-info" do
				expect(page).to have_content("Name: #{@merchant_1.name}")
				expect(page).to have_content("Email: #{@merchant_1.email}")
				expect(page).to have_content("Address: #{@merchant_1.address}")
				expect(page).to have_content("City: #{@merchant_1.city}")
				expect(page).to have_content("State: #{@merchant_1.state}")
				expect(page).to have_content("Zip Code: #{@merchant_1.zip}")
			end

		end
	end
end
