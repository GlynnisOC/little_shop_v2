require 'rails_helper'

RSpec.describe User, type: :model do
  it 'relationships' do
		it {should have_many :items}  
  end	
	
	describe 'validations' do
		it {should validate_presence_of :email}
		it {should validate_presence_of :password_digest}
		it {should validate_presence_of :role}
		it {should validate_presence_of :address}
		it {should validate_presence_of :city}
		it {should validate_presence_of :state}
		it {should validate_presence_of :zip}
	end
end
