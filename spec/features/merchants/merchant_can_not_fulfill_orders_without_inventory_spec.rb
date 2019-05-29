require 'rails_helper'

RSpec.describe 'As a merchant on my dashboard order show page' do
	describe 'if the desired quantity is more than my current inventory' do
		before :each do
			@merchant = create(:merchant)
			@user = create(:user)
			@order = create(:order, user: @user)
			@item_1 = create(:item, user: @merchant, inventory: 5)
			@item_2 = create(:item, user: @merchant, inventory: 1)
			@order_item_1 = create(:order_item, item: @item_1, order: @order, quantity: 3)
			@order_item_2 = create(:order_item, item: @item_2, order: @order, quantity: 3)
				
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
			binding.pry
		end

		it 'shows a big red notice, and there is no fulfill button' do
			visit dashboard_order_path(@order)
save_and_open_page
		end
	end
end
