require 'rails_helper'

RSpec.describe "As a visitor" do

  before :each do
    @user = User.create!(email: "user@email.com", password: "password", role: 0, active: true, name: "Yu Xer", address: "123 street", city: "News Userville", state:"US", zip: "80211")
    @merchant = User.create!(email: "merchant@email.com", password: "password", role: 1, active: true, name: "Murr Chante", address: "123 street", city: "Merchantston", state:"MR", zip: "80211")
    @admin = User.create!(email: "admin@email.com", password: "password", role: 2, active: true, name: "Addie Munn", address: "123 street", city: "West Adminster", state:"AD", zip: "80211")
  end

  describe "when I visit the login path" do
    it "I see a field to enter my email address and password" do

      visit login_path

      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_button("Login")
    end

    describe "when I submit valid information" do
      it "if regular user, I am redirected to my profile page" do
        visit login_path

        fill_in "Email", with:  "user@email.com"
        fill_in "Password", with: "password"
        click_button("Login")

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Logged in as #{@user.name}")
      end

      it "if merchant user, I am redirected to my merchant dashboard page" do
        visit login_path

        fill_in "Email", with:  "merchant@email.com"
        fill_in "Password", with: "password"
        click_button("Login")

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Logged in as #{@merchant.name}")
      end

      it "if admin user, I am redirected to the root page" do
        visit login_path

        fill_in "Email", with:  "admin@email.com"
        fill_in "Password", with: "password"
        click_button("Login")

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Logged in as #{@admin.name}")
      end

      describe "if invalid info given" do
        it "redirects to login and tells me credentials were incorrect" do
          visit login_path

          fill_in "Email", with:  "admin@email.com"
          fill_in "Password", with: "forgot"
          click_button("Login")

          expect(current_path).to eq(login_path)
          expect(page).to have_content("The email or password you entered was incorrect.")
        end
      end

      describe "if I am a registered user and logged in" do
        it "redirects me to my profile page" do
          visit login_path

          fill_in "Email", with:  "user@email.com"
          fill_in "Password", with: "password"
          click_button("Login")

          expect(current_path).to eq(profile_path)

          visit login_path
          expect(current_path).to eq(profile_path)
          click_on("Login")

          expect(current_path).to eq(profile_path(@user))
          # save_and_open_page
          expect(page).to have_content("#{@user.name}, you're already logged in!")
        end
      end

      describe "if I am a registered merchant and logged in" do
        it "redirects me to my profile page" do
          visit profile_path

          visit login_path
          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("#{@merchant.name}, you're already logged in!")
        end
      end

      describe "if I am a registered admin and logged in" do
        it "redirects me to my profile page" do
          visit profile_path

          visit login_path
          expect(current_path).to eq(root_path)
          expect(page).to have_content("#{@admin.name}, you're already logged in!")
        end
      end
    end
  end
end
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to the home page of the site
# And I see a flash message that tells me I am already logged in
