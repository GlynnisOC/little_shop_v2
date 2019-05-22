class MerchantsController < ApplicationController
  def index
  end

  def dashboard
		@merchant = User.find(current_user.id)
  end
end
