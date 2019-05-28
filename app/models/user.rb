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

	def self.all_reg_users
		where(role: 0)
	end

	def self.active_merchants
		where(role: 1).where(active: true).order(:name)
	end

	def self.all_merchants
		where(role: 1)
	end
end
