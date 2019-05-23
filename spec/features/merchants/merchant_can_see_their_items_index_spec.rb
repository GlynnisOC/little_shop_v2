require 'rails_helper'

RSpec.describe 'As a registered merchant on my dashboard page' do
	describe 'I see a link to view my own items' do
		it 'takes me to /dashboard/items' do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

			visit dashboard_path

			click_link "View My Items"

			expect(current_path).to eq('/dashboard/items')
		end
	end
end
