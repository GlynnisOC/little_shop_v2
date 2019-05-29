class OrderItem < ApplicationRecord
	belongs_to :item
	belongs_to :order

	validates_presence_of :quantity, :price

	# instance methods
	def item_name
		item.name
	end

	def item_image
		item.image
	end

	def fulfill
		if self.item.inventory >= self.quantity && !self.fulfilled?
			self.item.inventory = self.item.inventory - self.quantity
			self.fulfilled = true
			self.item.save
			self.save
		else
			false
		end
	end

	def valid_fulfill?
		quantity <= item.inventory
	end
end
