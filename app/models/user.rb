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

  has_secure_password

	enum role: [:default, :merchant, :admin]

	validates_confirmation_of :password_digest

end
