require 'rails_helper'

RSpec.describe 'As a registered merchant on the site' do
	describe 'when I visit my dashboard' do
		it 'shows my data and I cannot edit it' do 
			merchant = User.create!(email: "jimbob@bob.bob", password: "password", role: "merchant", name: "jimbob", address: "321 blastoff st", city: "Big Greasy Easy", state: "LA", zip: 38511) 
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

			visit dashboard_path

			within "#merchant-profile-info" do
				expect(page).to have_content("Name: #{merchant.name}")
				expect(page).to have_content("Email: #{merchant.email}")
				expect(page).to have_content("Address: #{merchant.address}")
				expect(page).to have_content("City: #{merchant.city}")
				expect(page).to have_content("State: #{merchant.state}")
			end
		end
	end
end
