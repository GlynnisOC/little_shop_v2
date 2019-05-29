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
		order(:status)
	end

	def total_items_in_order
		binding.pry
		order_items.sum(:quantity)
	end

	def total_value_in_order
		sum = 0
		order_items.each do |order_item|
			sum += (order_item.quantity * order_item.price)
		end
		sum
	end
end
# self.sum('order_items.quantity * items
# Order.select('SUM(order_items.quantity * items.price AS total_price)').joins(:order_items).joins(:items).where(id: self.id)
# Order.select('SUM(order_items.quantity * items.price) AS total_price').joins(:items).where(id: self.id)
# Order.select('SUM(order_items.quantity * order_items.price) AS total_price').joins(:order_items).where(id: self.id).group(:id)
