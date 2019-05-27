require 'rails_helper'

RSpec.describe 'As an admin on the merchant index ' do
	describe 'when I click the diable button for a enabled  merchant' do
		it 'enables the merchant account, posts a flash message, and allows the merchant to login' do
			merchant = create(:merchant)	
  	  admin = create(:admin) 
			visit login_path
  	  fill_in "Email", with: admin.email
  	  fill_in "Password", with: admin.password
  	  click_button("Login")
			
			visit admin_merchants_path
			click_button("Disable")
			expect(current_path).to eq(admin_merchants_path)
			expect(page).to have_content("#{merchant.name} is now disabled")
			click_link "Logout"

			merchant.reload
			binding.pry
			visit login_path
  	  fill_in "Email", with: merchant.email
  	  fill_in "Password", with: merchant.password
  	  click_button("Login")
			expect(current_path).to eq(dashboard_path)	
		end
	end
end
