require 'rails_helper'

RSpec.describe "when I log into the admin dashboard" do
  before :each do
		@admin_1 = create(:admin)
		@user_1 = create(:user)
    @order = create(:order)
    @order2 = create(:order)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
	end

  it "I can see all orders in the system and their id's" do
    visit admin_dashboard_path

    expect(page).to have_content("#{@order.id}")
    expect(page).to have_content("#{@order2.id}")
  end

  it "I can see the users who've placed the order and view their profile" do
    visit admin_dashboard_path

    expect(page).to have_content("#{@order.user.name}")
    click_on("#{@order.user.name}")
    expect(current_path).to eq(admin_user_path(@order.user))
  end
end

# For each order I see the following information:
# - date the order was created
#
# Orders are sorted by "status" in this order:
#
# - packaged
# - pending
# - shipped
# - cancelled
