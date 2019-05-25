class MerchantsController < ApplicationController
  def index
  end

  def dashboard
		@merchant = User.find(current_user.id)
    flash[:logged_in] = "#{@merchant.name}, you're already logged in!"
  end

end
