require 'rails_helper'

RSpec.describe 'As a user on the items index page' do
  describe 'I see all enabled items in the database' do
		before :each do 
			@merchant_1 = User.create!(email: "Bob@bob.bob", password_digest: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
		end

		it 'shows the name, thumbnail, merchant, inventory stock, and current price' do
						binding.pry
		end
	end
end
