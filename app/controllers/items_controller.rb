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
    @item = Item.new(item_params)
    @item[:user_id] = current_user.id
    @item.save
    if @item.save == false
      redirect_to new_dashboard_item_path
      flash[:message] = "New item information missing or invalid."
    else
      redirect_to dashboard_items_path
      flash[:message] = "Your new item has been saved"
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    redirect_to dashboard_items_path
    flash[:item_updated] = "Your item has been updated!"
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory)
  end
end
