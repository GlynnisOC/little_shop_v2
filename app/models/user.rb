class User < ApplicationRecord
	has_secure_password

	has_many :items
	has_many :orders

	validates_presence_of 	:name,
													:password_digest,
													:email,
													:role,
#													:active,
													:address,
													:city,
													:state,
													:zip


	validates_uniqueness_of :email

	enum role: [:default, :merchant, :admin]

	def downgrade_to_user
		update(role: 0)
	end

	def upgrade_to_merchant
		update(role: 1)
	end

	def enable_merchant
		update(active: true)
	end

	def disable_merchant
		update(active: false)
	end

	def item_disable
		items.update(active: false)
	end

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

	def top_three_citystates
		User.select("users.city || ', ' || users.state AS citystate", 'SUM(order_items.quantity) AS shipments')
				.joins(orders: :items)
				.where('orders.status = ?', 2)
				.where('items.user_id = ?', self.id)
				.group('citystate')
				.order('shipments DESC')
				.limit(3)
	end

	def top_user_by_orders
		top_user_id = User.select('orders.user_id AS unique_id', 'COUNT(DISTINCT(order_items.id)) AS unique_orders')
				.joins(orders: :items)
				.where('items.user_id = ?', self.id)
				.group('orders.user_id')
				.order('unique_orders DESC')
				.limit(1)
				.first

			User.find(top_user_id.unique_id) if top_user_id != nil
	end

	def top_user_by_items # refactor to return user object instead of user_id to minimize ruby calls on line 100 select all user info
		top_user_hash = Hash.new(0)
		top_user_id = User.select('orders.user_id AS unique_id', 'SUM(order_items.quantity) AS unique_items')
		.joins(orders: :items)
		.where('items.user_id = ?', self.id)
		.group('orders.user_id')
		.order('unique_items DESC')
		.limit(1).first

		if top_user_id != nil
			user = User.find(top_user_id.unique_id)
			top_user_hash[:user_name] = user.name
			top_user_hash[:unique_items] = top_user_id.unique_items
			top_user_hash
		end
	end

	def top_three_users_by_spending
		top_spender_hash = Hash.new(0)
		top_user_ids = User.select('orders.user_id AS unique_id', 'SUM(order_items.quantity * order_items.price) AS total_spending')
		.joins(orders: :items)
		.where('order_items.fulfilled = ?', true)
		.where('items.user_id = ?', self.id)
		.group('orders.user_id')
		.order('total_spending DESC')
		.limit(3)

		if top_user_ids != nil
			top_user_ids.each do |top_user_id|
				user = User.find(top_user_id.unique_id)
				top_spender_hash[user.name] = top_user_id.total_spending
			end
		end
		top_spender_hash
	end

	def self.all_reg_users
		where(role: 0)
	end

	def self.active_merchants
		where(role: 1).where(active: true).order(:name)
	end

	def self.all_merchants
		where(role: 1)
	end

	def self.top_three_revenue
					joins(items: :order_items)
					.where('order_items.fulfilled = ?', true)
					.group(:id)
					.select('sum(order_items.quantity * order_items.price) AS revenue, users.*')
					.order('revenue DESC')
					.limit(3)
	end

	def self.fastest_merchants
		joins(items: :order_items)
		.where('order_items.fulfilled = ?', true)
		.group(:id)
		.select('sum(order_items.updated_at - order_items.created_at) AS speed, users.*')
		.order('speed')
		.limit(3)
	end

end
