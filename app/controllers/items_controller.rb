class ItemsController < ApplicationController

  def index
		@active_items = Item.where_active
		@most_popular = Item.top_5
		@least_popular = Item.bottom_5

  end

  def show
    @item = Item.find(params[:id])
    @cart = Cart.new(session[:cart])
  end

  def create
    redirect_to dashboard_items_path
    flash[:message] = "Your new item has been saved"
  end


end
