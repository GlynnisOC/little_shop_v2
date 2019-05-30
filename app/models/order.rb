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


	def total_items_in_order
		order_items.sum(:quantity)
	end

	def status_changed_to_packaged
		order_item_status = order_items.all? do |order_item|
			order_item.fulfilled
		end
		if order_item_status == true
			update(status: "packaged")
		end
	end

	def total_value_in_order
		sum = 0
		order_items.each do |order_item|
			sum += (order_item.quantity * order_item.price)
		end
		sum
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

	# Class methods

	def self.status_sorted
		order(:status)
	end

	def self.largest_orders
					 where('orders.status = 2 AND order_items.fulfilled = true')
					.joins(:order_items).group(:id)
					.select('SUM(order_items.quantity) AS quantity, orders.*')
					.order('quantity DESC')
					.limit(3)
	end
	
end
