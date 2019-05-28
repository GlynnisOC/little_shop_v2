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
end
