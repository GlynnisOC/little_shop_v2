class Item < ApplicationRecord
		belongs_to :user
		
		def self.where_active
			Item.where(active: true)
		end
end
