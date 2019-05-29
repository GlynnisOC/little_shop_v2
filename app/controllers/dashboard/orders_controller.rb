class Dashboard::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = User.find(@order.user_id)

		binding.pry
    @my_order_items = OrderItem.joins(:item)\
    .where('items.user_id = ?', current_user.id)\
    .where('order_id = ?', @order.id)

  end
end
