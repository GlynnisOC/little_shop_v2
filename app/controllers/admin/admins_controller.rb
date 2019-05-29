class Admin::AdminsController < Admin::BaseController

  def dashboard
    @orders = Order.status_sorted
  end
end
