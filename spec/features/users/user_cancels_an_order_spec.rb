require 'rails_helper'

RSpec.describe 'As a default user on an order show page' do
	describe 'If the order is still pending, I see a link to cancel the order' do
		before :each do 
			@item_1 = create(:item)
			@item_2 = create(:item)
			@user = create(:user)
			@order = create(:order, user: @user)
			@order_item_1 = create(:order_item, order: @order, item: @item_1)	
			@order_item_2 = create(:order_item, order: @order, item: @item_2)	
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
			binding.pry
		end
		it 'toggles the order items to unfulfilled and the order to cancelled' do
			visit order_path(@order)
			click_link "Cancel Order"

			
		end
	end
end
