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

    if @item.save
      redirect_to dashboard_items_path
      flash[:message] = "Your new item has been saved"
    else
      render 'dashboard/items/new'
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    redirect_to dashboard_items_path
    flash[:item_updated] = "Your item has been updated!"
  end

  def disable
    @item = Item.find(params[:id])
    @item.disable_item
    flash[:disabled] = "#{@item.name} is no longer for sale"
    redirect_to dashboard_items_path
  end

  def enable
    @item = Item.find(params[:id])
    @item.enable_item
    flash[:enabled] = "#{@item.name} is now available for sale"
    redirect_to dashboard_items_path
  end

  def delete
    @item = Item.find(params[:id])
    current_user.items.delete(@item)
    flash[:deleted] = "#{@item.name} is now deleted"
    redirect_to dashboard_items_path
  end

  # refactor -- private method to find item and make this a before action

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory)
  end
end
