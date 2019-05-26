require 'rails_helper'

RSpec.describe 'As a visitor on the merchants index page' do
	before :each do
		@merchant_1 = create(:merchant)
		@merchant_2 = create(:merchant)
		@inactive_merchant = create(:inactive_merchant)
	end

	describe 'I see all active merchants' do
		it 'shows city, name, state, and registration date' do
			visit merchants_path

			within "#merchant-#{@merchant_1.id}-info" do
				expect(page).to have_content(@merchant_1.name)
				expect(page).to have_content(@merchant_1.city)
				expect(page).to have_content(@merchant_1.state)
				expect(page).to have_content(@merchant_1.create_at.strftime "%m-%d-%Y")
			end	

			
			within "#merchant-#{@merchant_2.id}-info" do
				expect(page).to have_content(@merchant_2.name)
				expect(page).to have_content(@merchant_2.city)
				expect(page).to have_content(@merchant_2.state)
				expect(page).to have_content(@merchant_2.create_at.strftime "%m-%d-%Y")
			end	

			expect(page).to_not have_content(@inactive_merchant.name)
		end
	end
end
