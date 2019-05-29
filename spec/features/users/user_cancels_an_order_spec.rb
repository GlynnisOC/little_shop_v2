require 'rails_helper'

RSpec.describe 'As a default user on an order show page' do
	describe 'If the order is still pending, I see a link to cancel the order' do

		before :each do
			@item_1 = create(:item, inventory: 100)
			@item_2 = create(:item, inventory: 100)
			@user = create(:user)
			@order = create(:order, user: @user)
			@order_item_1 = create(:order_item, order: @order, item: @item_1, quantity: 5, fulfilled: true)
			@order_item_2 = create(:order_item, order: @order, item: @item_2, quantity: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
		end

		it 'toggles the order items to unfulfilled' do
      visit order_show_path(@order)

      expect(@order_item_1.fulfilled).to eq(true)
      expect(@order_item_2.fulfilled).to eq(false)

      click_button "Cancel Order"

      @order_item_1.reload
      @order_item_2.reload
      expect(@order_item_1.fulfilled).to eq(false)
      expect(@order_item_2.fulfilled).to eq(false)
		end

		it 'toggles the order from pending to cancelled' do
      visit order_show_path(@order)
      expect(@order.status).to eq("pending")

      click_button "Cancel Order"

      expect(page).to have_content("Order #{@order.id} is now cancelled")
      @order.reload
      expect(@order.status).to eq("cancelled")
		end

		it 'takes user to profile path' do
      visit order_show_path(@order)

      click_button "Cancel Order"

      expect(current_path).to eq(profile_path)
		end

		it 'reloads inventory for order_items that were previously fulfilled' do
      visit order_show_path(@order)

      expect(@order_item_1.fulfilled).to eq(true)
      expect(@order_item_2.fulfilled).to eq(false)

      expect(@item_1.inventory).to eq(100)
      expect(@item_2.inventory).to eq(100)

      click_button "Cancel Order"

      @item_1.reload
      @item_2.reload
      expect(@item_1.inventory).to eq(105)
      expect(@item_2.inventory).to eq(100)
		end
	end
end
