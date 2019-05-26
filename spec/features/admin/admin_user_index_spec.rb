require 'rails_helper'

RSpec.describe 'As an admin user' do
	describe 'When I click a new users link in the admin nav' do
		before :each do
			@admin_1 = create(:admin)
			@user_1 = create(:user)
			@user_1 = create(:user)
		end

		it 'shows all reg users names as a show page link' do
			visit root_path
			expect(page).to_not have_link("Users")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
			click_link("Users")
			
			within "user-#{@user_1.id}-info" do
				expect(page).to have_link(@user_1.name)	
			end

			within "user-#{@user_2.id}-info" do
				expect(page).to have_link(@user_2.name)	
			end

			click_link(@user_2.name)

			expect(current_path).to eq(user_path(@user_1))
		end

		it 'shows each user registration date and a button to upgrade that user to merchant' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
			visit admin_users_path 

			within "user-#{@user_1.id}-info" do
				expect(page).to have_content(@user_1.created_at)
				expect(page).to have_button("Upgrade to Merchant")
			end

			within "user-#{@user_2.id}-info" do
				expect(page).to have_content(@user_2.created_at)
				expect(page).to have_button("Upgrade to Merchant")
			end
		end
	end
end


