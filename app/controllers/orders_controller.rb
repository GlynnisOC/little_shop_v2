class OrdersController < ApplicationController

  def index
		if current_user != nil
			@user = current_user
		else
    	@user = User.find(params[:user_id]) || current_user
		end
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.distinct
  end
end
