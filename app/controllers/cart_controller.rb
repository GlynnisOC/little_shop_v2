class CartController < ApplicationController
  before_action :require_visitor_or_default

  def require_visitor_or_default
    render file: "/public/404", status: 404 unless current_user == nil || current_user.default?
  end


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
    session[:cart] = {}
    redirect_to cart_path
  end

  def change_amount
    @item = Item.find(params[:item_id])
    item_id_str = @item.id.to_s
    if @item.inventory >= session[:cart][item_id_str] + params[:change_amount].to_i
      session[:cart][item_id_str] += params[:change_amount].to_i
    end
    session[:cart] = session[:cart].reject{ |item_id, quantity| quantity <= 0 }
    redirect_to cart_path
  end

	def check_out
		order = current_user.orders.create
		cart.contents.each do |id, quant|
			item = Item.find(id)
			order_item = OrderItem.new(quantity: quant, price: item.price)
			order.order_items << order_item
			item.order_items << order_item
			order_item.save
		end
		order.save
		flash[:check_out] = "Your order has been placed"
		cart.contents.keys.each {|key| cart.contents.delete(key)}
		redirect_to profile_orders_path
	end
end
