class CartsController < ApplicationController

  def index

  end

  def create
    @item = Item.find(params[:item_id])
    flash[:message] = "#{@item.name} has been added to your cart"
    redirect_to items_path



  end

end
