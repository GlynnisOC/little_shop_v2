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

	# validates_presence_of :name, :password, :email
	# validates_uniqueness_of :email, 

	enum role: [:default, :merchant, :admin]

end
