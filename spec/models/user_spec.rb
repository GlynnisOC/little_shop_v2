require 'rails_helper'

RSpec.describe User, type: :model do
	before :each do 
      @merchant_1 = User.create!(email: "@merchant_1@gmail.com", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

      @merchant_2 = create(:merchant) 
      @inactive_merchant = create(:inactive_merchant) 
      @admin_1 = User.create!(email: "@admin_1@gmail.com", password: "password", role: 2, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

		
      @user_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 0, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")
      @user_2 = create(:inactive_user) 
	end

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

      expect(@merchant_1.role).to eq("merchant")
      expect(@merchant_1.merchant?).to be_truthy
    end

    it "can be created as an admin" do

      expect(@admin_1.role).to eq("admin")
      expect(@admin_1.admin?).to be_truthy
    end

    it "can be created as a default user" do

      expect(@user_1.role).to eq("default")
      expect(@user_1.default?).to be_truthy
    end
  end

	describe 'instance methods' do 
		it '#upgrade_to_merchant' do
			@user_1.upgrade_to_merchant
			@user_1.reload
			expect(@user_1.role).to eq(1)
		end
	end

  describe 'class methods' do
    it ".email_taken" do
      User.create(name: "Bobby", email: "aol@gmail.com", password: "password", address: "123 6th ave", city: "Denver", state: "Colorado", zip: "80226")
      email = "aol@gmail.com"

      expect(User.email_taken(email)).to be_truthy
    end
		
		it '.all_reg_users' do
			expect(User.all_reg_users).to eq([@user_1, @user_2])
		end

		it '.active_merchants' do
			expect(User.active_merchants).to eq([@merchant_1, @merchant_2])
		end
  end
end
