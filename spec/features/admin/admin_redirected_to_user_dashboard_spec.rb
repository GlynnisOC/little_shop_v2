require 'rails_helper'

RSpec.describe 'As an admin user' do
	describe 'if I visit the merchant dashboard of a regular user' do
		before :each do 
			@admin = create(:admin)
			@user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
		end

		it 'redirects me to the proper admin user show page' do
			visit admin_merchant_path(@user)
			expect(current_path).to eq(admin_user_path(@user))
		end
	end
end
