class ItemsController < ApplicationController

  def index
		@active_items = Item.where_active
  end 
end
