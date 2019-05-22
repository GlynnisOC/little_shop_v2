class User < ApplicationRecord
	has_secure_password

	has_many :items

	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	validates :role, presence: true
	validates :active, presence: true
	validates :name, presence: true
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true

	enum role: [:default, :merchant, :admin]

	def self.email_taken(email)
		where(email: email) != []
	end

end
