require 'rails_helper'

RSpec.describe "As a registered user" do

  before :each do
    @user = User.create!(email: "user@email.com", password: "password", role: 0, active: true, name: "Yu Xer", address: "123 street", city: "News Userville", state:"US", zip: "80211")
    @user_2 = User.create!(email: "user2@email.com", password: "password", role: 0, active: true, name: "Yuzer Too", address: "123 street", city: "Youzintry", state:"US", zip: "80211")
  end

  describe "when I visit my profile page" do
    it "I see a link to edit my profile" do
      visit login_path

      fill_in "Email", with: "#{@user.email}"
      fill_in "Password", with: "#{@user.password}"
      click_button("Login")

      visit profile_path

      click_link("Edit Profile")
      expect(current_path).to eq(profile_edit_path)
      expect(page).to have_content("#{@user.name}")
      expect(page).to_not have_content("#{@user.password}")

      fill_in "Street Address", with: "675 5th St."
      fill_in "City", with: "Yuxerton"
      click_button("Update Profile")

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("#{@user.name}, your profile is updated!")
      expect(@user.reload.address).to eq("675 5th St.")
      expect(@user.reload.city).to eq("Yuxerton")
    end

    it "doesn't let me change my email address to another user's" do
      visit login_path

      fill_in "Email", with: "#{@user.email}"
      fill_in "Password", with: "#{@user.password}"
      click_button("Login")

      visit profile_path

      click_link("Edit Profile")
      fill_in "Email", with: "user2@email.com"
      click_button("Update Profile")

      expect(current_path).to eq(profile_edit_path)
      expect(page).to have_content("That email address is taken.")
    end
  end
end
