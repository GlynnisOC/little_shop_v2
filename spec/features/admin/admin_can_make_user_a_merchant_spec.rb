require 'rails_helper'

RSpec.describe 'As an admin user on an admin user show page' do
	describe 'I see a link to upgrade that user to a merchant' do
		before :each do 
			@admin = create(:admin)
			@user = create(:user)

			visit login_path
			fill_in "Email", with: "admin_1@gmail.com"
			fill_in "Password", with: "password"
			click_button "Login"	
			visit admin_user_path(@user)
		end

		it 'upgrades and redirects to their show page where I see a flash message' do
			click_link("Upgrade to Merchant")

			expect(current_path).to eq(admin_merchant_path(@user))	
			expect(page).to have_content("#{@user.name} is now a merchant")			
			@user.reload
			expect(@user.role).to eq(1)	
		end

		it 'the user is a merchant the next time they log in' do
			click_link("Upgrade to Merchant")

			visit logout_path
			visit login_path
	
			fill_in "Email", with: "user_1@gmail.com"
			fill_in "Password", with: "password"
			click_button "Login"	

			expect(current_path).to eq(dashboard_path)
		end
	end
end
