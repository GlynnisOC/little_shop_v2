class Admin::AdminsController < ActionController::Base

  def dashboard
    @orders = Order.all
  end

end
