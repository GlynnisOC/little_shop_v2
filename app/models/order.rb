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
				order_item.item.update(inventory: order_item.item.inventory + order_item.quantity)
			end
			order_item.update(fulfilled: false)
		end
	end
end
