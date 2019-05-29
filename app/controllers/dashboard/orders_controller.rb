class Dashboard::OrdersController < Dashboard::BaseController

  def show
    @order = Order.find(params[:id])
    @customer = User.find(@order.user_id)

    @my_order_items = OrderItem.joins(:item)\
    .where('items.user_id = ?', current_user.id)\
    .where('order_id = ?', @order.id)
  end

	def fulfill
		@order = Order.find(params[:order])
		@order_item = OrderItem.find(params[:id])
		if @order_item.fulfill != false
			flash[:fulfilled] = "#{@order_item.item.name} has been fulfilled"
			redirect_to dashboard_order_path(@order)
		end
	end
end
