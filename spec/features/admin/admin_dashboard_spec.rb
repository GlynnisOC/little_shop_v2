require 'rails_helper'

RSpec.describe "when I log into the admin dashboard" do
  before :each do
		@admin_1 = create(:admin)
		@user_1 = create(:user)
    @order = create(:order)
    @order2 = create(:order)
    @order3 = create(:order)
    @order4 = create(:order)
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

  it "I can see the date the order was created" do
    visit admin_dashboard_path

    expect(page).to have_content("#{@order.created_at}")
    expect(page).to have_content("#{@order2.created_at}")
  end

  it "I can see the orders sorted by packaged, pending, shipped, and cancelled" do
    order = create(:order)
    order2 = create(:order)
    order3 = create(:order)
    order4 = create(:order)
    order.status = 0
    order2.status = 1
    order3.status = 2
    order4.status = 3
    visit admin_dashboard_path
    # binding.pry
    # save_and_open_page

    expect(page).to have_content("#{order.status}")
    expect(page).to have_content("#{order2.status}")
    expect(page).to have_content("#{order3.status}")
    expect(page).to have_content("#{order4.status}")
  end
end
