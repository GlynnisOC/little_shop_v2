require 'rails_helper'

RSpec.describe 'as an admin user on my dashboard'  do
	describe 'I see packaged orders ready to ship' do
		describe 'and each order has a button to ship the order' do
			before :each do
				@admin_1 = create(:admin)
				allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)

				@order_1 = create(:order)
				@order_2 = create(:packaged_order)
				@order_3 = create(:shipped_order)
				@order_4 = create(:cancelled_order)
				visit admin_dashboard_path
			end

			it 'button exists when order status is packaged_order' do
				within "#admin-dashboard-order-#{@order_1.id}" do
					expect(page).to_not have_button("Ship Order")
				end

				within "#admin-dashboard-order-#{@order_2.id}" do
					expect(page).to have_button("Ship Order")
				end

				within "#admin-dashboard-order-#{@order_3.id}" do
					expect(page).to_not have_button("Ship Order")
				end

				within "#admin-dashboard-order-#{@order_4.id}" do
					expect(page).to_not have_button("Ship Order")
				end
			end

			it 'clicking Ship Order button updates order.status to Shipped' do
				expect(@order_2.status).to eq("packaged")

				within "#admin-dashboard-order-#{@order_2.id}" do
					click_button("Ship Order")
				end
				@order_2.reload
				expect(@order_2.status).to eq("shipped")
			end
		end
	end
end
