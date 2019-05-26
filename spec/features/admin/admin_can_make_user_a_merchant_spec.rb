require 'rails_helper'

RSpec.describe 'As an admin user on an admin user show page' do
	describe 'I see a link to upgrade that user to a merchant' do
		before :each do 
			@admin = create(:admin, email: "admin_1@gmail.com")
			@user_1 = create(:user, email: "user_1@gmail.com")
			@user_2 = create(:user, email: "user_2@gmail.com")
			visit login_path
			fill_in "Email", with: "admin_1@gmail.com"
			fill_in "Password", with: "password"
			click_button "Login"	
		end

		it 'upgrades and redirects to their show page where I see a flash message' do
			visit admin_user_path(@user_1)
			click_link("Upgrade to Merchant")

			expect(current_path).to eq(admin_merchant_path(@user_1))	
			expect(page).to have_content("#{@user_1.name} is now a merchant")			
			visit logout_path
		end

	it 'the user is a merchant the next time they log in' do
			visit admin_user_path(@user_2)
			click_link("Upgrade to Merchant")

			visit logout_path
			visit login_path
	
			fill_in "Email", with: "user_2@gmail.com"
			fill_in "Password", with: "password"
			click_button "Login"	

			expect(current_path).to eq(dashboard_path)
		end
	end
end
