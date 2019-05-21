class User < ApplicationRecord
	validates :email, presence: true
	validates :password_digest, presence: true
	validates :role, presence: true
	validates :active, presence: true
	validates :name, presence: true
	validates :address, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zip, presence: true
end
