class OrdersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
    @items = @order.items.distinct
  end
end
