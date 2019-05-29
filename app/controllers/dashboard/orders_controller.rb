class Dashboard::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @customer = User.find(@order.user_id)

    # OrderItem.joins(:item).where('items.user_id = ?', current_user.id)

    @my_order_items = OrderItem.joins(:item)\
    .where('items.user_id = ?', current_user.id)\
    .where('order_id = ?', @order.id)

  end

  # As a merchant
  # When I visit an order show page from my dashboard
  # I see the customer's name and address
  # I only the items in the order that are being purchased from my inventory
  # I do not see any items in the order being purchased from other merchants
  # For each item, I see the following information:
  # - the name of the item, which is a link to my item's show page
  # - a small thumbnail of the item
  # - my price for the item
  # - the quantity the user wants to purchase

end
