require 'rails_helper'

RSpec.describe 'As an admin user' do
	describe 'if I visit the user dashboard of a merchant user' do
		before :each do 
			@admin = create(:admin)
			@merchant= create(:merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
		end

		it 'redirects me to the proper admin user show page' do
			visit admin_user_path(@merchant)
			expect(current_path).to eq(admin_merchant_path(@merchant))
		end
	end
end
