class ItemsController < ApplicationController

  def index
		@active_items = Item.where_active
  end

  def show
    @item = Item.find(params[:id])
  end

end
