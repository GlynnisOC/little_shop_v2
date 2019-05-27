class User < ApplicationRecord
	has_secure_password

	has_many :items
	has_many :orders


	validates_presence_of 	:name,
													:password_digest,
													:email,
													:role,
													:active,
													:address,
													:city,
													:state,
													:zip


	validates_uniqueness_of :email

	enum role: [:default, :merchant, :admin]

	def self.email_taken(email)
		where(email: email) != []
	end

	def top_five_items_sold
		items.select(:name, 'SUM(order_items.quantity) AS item_quantity')
				 .joins(:order_items)
				 .where('order_items.fulfilled = ?', true)
				 .group(:id)
				 .order('item_quantity DESC')
				 .limit(5)
	end

	def all_items_sold
		items.joins(:order_items)
				 .where('order_items.fulfilled = ?', true)
				 .sum('order_items.quantity')
	end

	def total_starting_inventory
		items.distinct.joins(:order_items).where('order_items.fulfilled = ?', true).sum('items.inventory')
	end

	def top_three_states
		User.select(:state, 'SUM(order_items.quantity) AS shipments')
				.joins(orders: :items)
				.where('orders.status = ?', 2)
				.where('items.user_id = ?', self.id)
				.group(:state)
				.order('shipments DESC')
				.limit(3)
	end



end
