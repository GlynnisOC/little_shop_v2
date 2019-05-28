class MerchantsController < ApplicationController
  def index
		@active_merchants = User.active_merchants
  end

  def dashboard
		@merchant = User.find(current_user.id)
    flash[:logged_in]            = "#{@merchant.name}, you're already logged in!"
    @top_five_items_sold         = @merchant.top_five_items_sold
    @all_items_sold              = @merchant.all_items_sold
    @total_starting_inventory    = @merchant.total_starting_inventory
    @top_three_states            = @merchant.top_three_states
    @top_three_citystates        = @merchant.top_three_citystates
    @top_user_by_orders          = @merchant.top_user_by_orders
    @top_user_by_items           = @merchant.top_user_by_items
    @top_three_users_by_spending = @merchant.top_three_users_by_spending
  end
end
