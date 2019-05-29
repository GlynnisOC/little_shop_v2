class OrderItem < ApplicationRecord
	belongs_to :item
	belongs_to :order

	validates_presence_of :quantity, :price

	# instance methods
	def item_name
		item.name
	end

end
