class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items
	has_many :items, through: :order_items

	enum status: [:pending, :packaged, :shipped, :cancelled]

	def order_grand_total
		items.sum(:price)
	end

	def item_quantity(item_id)
		items.count { |item| item.id == item_id }
	end

	def self.status_sorted
		Order.order(:status)
	end

	def ship_packaged_order
		update(status: "shipped")
	end

	def cancel_pending_order
		update(status: "cancelled")

		self.order_items.each do |order_item|
			if order_item.fulfilled == true
				order_item.item.inventory += order_item.quantity
			end
			order_item.update(fulfilled: false)
		end
	end
end

# As a registered user
# When I visit an order's show page
# If the order is still "pending", I see a button or link to cancel the order
# When I click the cancel button for an order, the following happens:
# - Each row in the "order items" table is given a status of "unfulfilled"
# - The order itself is given a status of "cancelled"
# - Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
# - I am returned to my profile page
# - I see a flash message telling me the order is now cancelled
# - And I see that this order now has an updated status of "cancelled"
