require 'rails_helper'

RSpec.describe 'as an admin on a merchant show page' do
	describe 'I see a link to downgrade that merchant to a user' do
		before :each do
			@admin = create(:admin)
			@merchant = create(:merchant)
			@item_1 = create(:item, user: @merchant)
			@item_2 = create(:item, user: @merchant)
		end

		it 'is unavailable for the merchants to see' do
			visit login_path
  	  fill_in "Email", with: @merchant.email
  	  fill_in "Password", with: @merchant.password
  	  click_button("Login")
			visit admin_merchant_path(@merchant)
			expect(page).to have_content("The page you were looking for doesn't exist.")
			expect(page).to_not have_link("Downgrade to User")
		end

		it 'downgrades, displays a flash message, and redirects when clicked' do
			visit login_path
  	  fill_in "Email", with: @admin.email
  	  fill_in "Password", with: @admin.password
  	  click_button("Login")
			visit admin_merchant_path(@merchant)
			click_link("Downgrade to User")
			expect(page).to have_content("#{@merchant.name} has been downgraded to a regular user")
			expect(current_path).to eq(admin_user_path(@merchant))
		end

		it 'no longer allows the user to log in as a merchant and disables their items' do
			visit login_path
  	  fill_in "Email", with: @admin.email
  	  fill_in "Password", with: @admin.password
  	  click_button("Login")
			visit admin_merchant_path(@merchant)
			click_link("Downgrade to User")
			visit logout_path

			@merchant.reload
			visit login_path
  	  fill_in "Email", with: @merchant.email
  	  fill_in "Password", with: @merchant.password
  	  click_button("Login")
			expect(current_path).to eq(profile_path)

			@item_1.reload
			@item_2.reload
			expect(@item_1.active).to be_falsey
			expect(@item_2.active).to be_falsey
		end
	end
end
