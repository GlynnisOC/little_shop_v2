require 'rails_helper'

describe Item, type: :model do
	describe 'relationships' do
		it {should belong_to user} 
	end
end
