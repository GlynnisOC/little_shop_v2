class Admin::MerchantsController < ApplicationController
	def index
		@all_merchants = User.all_merchants
	end

	def show
		@merchant = User.find(params[:id])
	end
end
