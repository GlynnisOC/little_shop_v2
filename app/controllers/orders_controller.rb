class OrdersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def show
  end
end