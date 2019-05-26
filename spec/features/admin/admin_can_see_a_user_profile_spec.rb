require 'rails_helper'

RSpec.describe 'As an admin user on a user profile page' do
	before :each do
		@admin_1 = create(:admin)
		@user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
	end

		it 'shows the same information the user would see without an edit profile link' do
			visit admin_user_path(@user_1)

			within "#user-#{@user_1.id}-profile-info" do
				expect(page).to have_content("Name: #{@user_1.name}")
				expect(page).to have_content("Email: #{@user_1.email}")
				expect(page).to have_content("Address: #{@user_1.address}")
				expect(page).to have_content("City: #{@user_1.city}")
				expect(page).to have_content("State: #{@user_1.state}")
				expect(page).to have_content("Zip Code: #{@user_1.zip}")
			end
			
		end
end
