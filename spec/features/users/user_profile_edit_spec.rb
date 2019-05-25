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
      fill_in "Password", with: "pword"
      click_button("Update Profile")

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("#{@user.name}, your profile is updated!")
      expect(@user.reload.address).to eq("675 5th St.")
      expect(@user.reload.city).to eq("Yuxerton")
    end
  end


  describe "when I visit the login path" do
    it "I see a field to enter my email address and password" do

      visit login_path

      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_button("Login")
    end
  end
end

# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# Then my current URI route is "/profile/edit"
# I see a form like the registration page
# The form contains all of my user information
# The password fields are blank and can be left blank
# I can change any or all of the information
# When I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information
