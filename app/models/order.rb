class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items
	has_many :items, through: :order_items

	belongs_to :user

	enum status: [:pending, :packaged, :shipped, :cancelled]

	def order_grand_total
		self.items.sum(:price)
	end

end
