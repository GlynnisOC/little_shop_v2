class Admin::AdminsController < ActionController::Base

  def dashboard
    @orders = Order.status_sorted
  end
end
