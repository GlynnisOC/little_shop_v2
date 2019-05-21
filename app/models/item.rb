class Item < ApplicationRecord
		belongs_to :user
		has_many :order_items
		
		def self.where_active
			Item.where(active: true)
		end
end
