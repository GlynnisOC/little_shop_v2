require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
		it {should have_many :items}
  end

	describe 'validations' do
		it {should validate_presence_of :email}
		it {should validate_uniqueness_of :email}
		it {should validate_presence_of :password}
		it {should validate_presence_of :role}
		it {should validate_presence_of :address}
		it {should validate_presence_of :city}
		it {should validate_presence_of :state}
		it {should validate_presence_of :zip}
	end

  describe 'roles' do
    it "can be created as a merchant" do
      merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      expect(merchant_1.role).to eq("merchant")
      expect(merchant_1.merchant?).to be_truthy
    end

    it "can be created as an admin" do
      admin_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      expect(admin_1.role).to eq("admin")
      expect(admin_1.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      expect(user_1.role).to eq("default")
      expect(user_1.default?).to be_truthy
    end
  end

end
