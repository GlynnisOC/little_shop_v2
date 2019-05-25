class CartController < ApplicationController

  def show
    @items_in_cart = cart.contents
    @cart_items = Item.where(id: cart.item_ids)
  end

  def create
    @item = Item.find(params[:item_id])
    item_id_str = @item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] += 1
    flash[:message] = "#{@item.name} has been added to your cart"
    redirect_to items_path
  end

  def empty_cart
    reset_session
    redirect_to cart_path
  end

  def change_amount
    @item = Item.find(params[:item_id])
    item_id_str = @item.id.to_s
    session[:cart][item_id_str] += params[:change_amount].to_i
    session[:cart] = session[:cart].reject{ |item_id, quantity| quantity <= 0 }
    redirect_to cart_path
  end
end
