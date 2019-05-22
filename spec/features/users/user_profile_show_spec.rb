require 'rails_helper'

RSpec.describe 'As a registered user' do
	describe 'I see my profile data' do
		it 'shows all info excluding password, and a link to edit the info' do
			user = User.create!(email: "joebob@jimbob.bobbob", password: "password", name: "joebob", address: "123 street", city: "Atlantis", state:"I am the cosmic state of affairs", zip: "80211") 

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit profile_path

			within "#user-profile-info" do
				expect(page).to have_content("Name: #{user.name}")
				expect(page).to have_content("Email: #{user.email}")
				expect(page).to have_content("Address: #{user.address}")
				expect(page).to have_content("City: #{user.city}")
				expect(page).to have_content("State: #{user.state}")
				expect(page).to have_content("Zip Code: #{user.zip}")
			end
		end
	end
end
