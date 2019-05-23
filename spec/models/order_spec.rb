require 'rails_helper'

RSpec.describe Order, type: :model do
	describe 'relationships' do
		it {should have_many :order_items}
	end
end
