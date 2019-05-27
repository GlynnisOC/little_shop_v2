class Admin::AdminsController < ActionController::Base

  def dashboard
    @orders = Order.all
    @user = @orders.map { |order| order.user_id }
  end
end
