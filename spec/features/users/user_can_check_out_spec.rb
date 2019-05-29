require 'rails_helper'

RSpec.describe 'as a registered user with items in my cart' do
	describe 'I see a button or a link to checkout' do
		before :each do
			@user = create(:user)
			@item_1 = create(:item)
			@item_2 = create(:item)
			
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
			visit item_path(@item_1)
			click_button "Add to Cart"
			visit item_path(@item_2)
			click_button "Add to Cart"
			visit cart_path
		end

		it 'creates a pending order, empties my cart, and redirects to profile/orders with a flash message' do
			click_button("Check Out")
			expect(current_path).to eq('/profile/orders')
			expect(Order.all).to eq(1)
			expect(page).to have_content("Your order has been placed")
		save_and_open_page		
		end
	end
end
