require 'rails_helper'

RSpec.describe 'As a merchant on a dashboard order show page' do
	describe 'for each sufficienctly stocked item of mine in the order' do
		before :each do
			@merchant = create(:merchant)
			@user = create(:user)
			@order = create(:order, user: @user)
			@item_1 = create(:item, user: @merchant, inventory: 5)
			@item_2 = create(:item, user: @merchant, inventory: 5)
			@order_item_1 = create(:order_item, item: @item_1, order: @order, quantity: 3)
			@fulfilled_order_item = create(:fulfilled_order_item, item: @item_2, order: @order, quantity: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
			visit dashboard_order_path(@order)
		end

		it 'has a button to fulfill the order that fulfills and updates the show page' do
  	  within  "my-order-item-#{@order_item_1.id}" do
				click_button "Fulfill Order"
				expect(page).to have_content("#{@order_item_1} has been fulfilled")	
				expect(current_path).to eq(dashboard_order_path(@order))
				@item_1.reload
				expect(@item_1.inventory).to eq(2)
				expect(page).to_not have_button "Fulfill Order"
			end

  	  within  "my-order-item-#{@fulfilled_order_item.id}" do
				expect(page).to_not have_button "Fulfill Order"
				expect(page).to have_content("This item has been fulfilled")	
			end
		end
	end
end
