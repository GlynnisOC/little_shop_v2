class OrdersController < ApplicationController

  def index
		@user = current_user if current_user != nil
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

  def cancel_pending_order
    @order = Order.find(params[:id])
    @order.cancel_pending_order
    redirect_to profile_path
    flash[:order_cancelled] = "Order #{@order.id} is now cancelled"
  end
end
