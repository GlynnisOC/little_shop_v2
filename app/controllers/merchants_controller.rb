class MerchantsController < ApplicationController
  def index
		@active_merchants = User.active_merchants
    @top_three_revenue = User.top_three_revenue
    @fastest_merchants = User.fastest_merchants
    @slowest_merchants = User.slowest_merchants
    @most_popular_states = User.most_popular_states
    @most_popular_cities = User.most_popular_cities
    @largest_orders = Order.largest_orders
  end

  def dashboard
		@merchant = User.find(current_user.id)
    flash[:logged_in]            = "#{@merchant.name}, you're already logged in!"
    @orders                      = Order.all
    @total_items_in_order        = @orders.find_by(params[:order_id]).total_items_in_order if params[:order_id] != nil
    @total_value_in_order        = @orders.find_by(params[:order_id]).total_value_in_order if params[:order_id] != nil
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
