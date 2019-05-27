class MerchantsController < ApplicationController
  def index
  end

  def dashboard
		@merchant = User.find(current_user.id)
    flash[:logged_in] = "#{@merchant.name}, you're already logged in!"
    @top_five_items_sold = @merchant.top_five_items_sold
    @all_items_sold = @merchant.all_items_sold
    @total_starting_inventory = @merchant.total_starting_inventory
    @top_three_states = @merchant.top_three_states

  end

end
