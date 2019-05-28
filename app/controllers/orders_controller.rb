class OrdersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.distinct
  end

  def ship_packaged_order
    @order = Order.find(params[:id])
    @order.ship_packaged_order
    redirect_to admin_dashboard_path
  end
end
