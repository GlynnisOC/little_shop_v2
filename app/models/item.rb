class Item < ApplicationRecord
		belongs_to :user
		has_many :order_items
		has_many :orders, through: :order_items

		validates_presence_of :name, :price, :description, :image, :inventory
	  validates :price, numericality: { greater_than: 0 }
	  validates :inventory, numericality: { greater_than_or_equal_to: 0 }

		def self.where_active
			Item.where(active: true)
		end

		def self.top_5
			Item.select('DISTINCT(name), SUM(order_items.quantity)')
						.joins(:order_items)
						.where('order_items.fulfilled = true AND items.active = true')
						.group(:id)
						.order('sum DESC')
						.limit(5)
		end

		def self.bottom_5
			Item.select('DISTINCT(name), SUM(order_items.quantity)')
						.joins(:order_items)
						.where('order_items.fulfilled = true')
						.group(:id)
						.order('sum')
						.limit(5)
		end

		def average_time_to_fulfill
			order_items.where(fulfilled: true).average('updated_at - created_at')
		end
		
end
