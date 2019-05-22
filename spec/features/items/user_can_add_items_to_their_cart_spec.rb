require 'rails_helper'

RSpec.describe "When a user adds items to their cart" do
  before :each do
    @merchant_1 = User.create!(email: "Bob@bob.bob", password: "password", role: 1, active: true, name: "Bob Bob", address: "123 Shady Lane", city: "Boulda", state: "CO", zip: "80303")

    @active_item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 1.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 100)
    @active_item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 2.00, description: "Buy things with your MONEY!", image: "https://images.unsplash.com/photo-1443557661966-8b4795a6f62c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", inventory: 200)

    @inactive_item =  @merchant_1.items.create!(name: "this is a word", active: false, price: 2.00, description: "Buy things with your MONEY!", image: "fake url", inventory: 200)
  end

  it "displays a message" do
    visit items_path

    within "#item-#{@active_item_1.id}" do
      click_link("#{@active_item_1.name}")
    end
    expect(page).to have_button("Add to Cart")
    click_on("Add to Cart")

    expect(current_path).to eq(items_path)
    expect(page).to have_content("#{@active_item_1.name} has been added to your cart")
  end

  it "displays the total number of items in the cart" do

    visit item_path(@active_item_1.id)

    expect(page).to have_content("Cart: 0")

    within("#visitor-nav-cart") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("Cart: 1")

    visit item_path(@active_item_1.id)

    within("#visitor-nav-cart") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("Cart: 2")

    visit item_path(@active_item_2.id)
    
    within("#visitor-nav-cart") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("Cart: 3")
  end
end
