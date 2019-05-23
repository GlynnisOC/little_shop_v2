class User < ApplicationRecord
	has_secure_password

	has_many :items

	validates_presence_of 	:name,
													:password,
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

end
