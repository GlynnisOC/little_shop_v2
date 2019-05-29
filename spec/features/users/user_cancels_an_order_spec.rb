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
		end

		it 'toggles the order items to unfulfilled and the order to cancelled' do
      visit order_show_path(@order)
      expect(@order.status).to eq("pending")
      expect(page).to have_button("Cancel Order")

      click_button "Cancel Order"

      expect(current_path).to eq()

      # require 'pry'; binding.pry
      # save_and_open_page


		end
	end
end
