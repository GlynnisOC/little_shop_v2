require 'rails_helper'

RSpec.describe 'As an admin user' do
	describe 'when I visit the merchants index page' do
		before :each do
			@merchant_1 = create(:merchant)
			@merchant_2 = create(:merchant)
			@merchant_3 = create(:inactive_merchant)

			@admin_1 = create(:admin)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
		end

		it 'shows all merchants in the system, with info and show links' do
			visit admin_merchants_path
			
			within "#merchant-#{@merchant_1.id}-info" do
				expect(page).to have_content(@merchant_1.city)
				expect(page).to have_content(@merchant_1.state)
				expect(page).to have_button("Disable")
				click_link(@merchant_1.name)
				expect(current_path).to eq(admin_merchant_path(@merchant_1))
			end

			within "#merchant-#{@merchant_2.id}-info" do
				expect(page).to have_content(@merchant_2.city)
				expect(page).to have_content(@merchant_2.state)
				expect(page).to have_button("Disable")
				click_link(@merchant_2.name)
				expect(current_path).to eq(admin_merchant_path(@merchant_2))
			end

			within "#merchant-#{@merchant_3.id}-info" do
				expect(page).to have_button("Enable")
			end
		end
	end
end
