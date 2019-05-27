class Admin::MerchantsController < ApplicationController
	def index
		@all_merchants = User.all_merchants
	end

	def show
		@merchant = User.find(params[:id])
	end

	def enable
		@merchant = User.find(params[:id])
		@merchant.enable_merchant
		flash[:enabled] = "#{@merchant.name} is now enabled"
		redirect_to admin_merchants_path
	end

	def disable
		@merchant = User.find(params[:id])
		@merchant.disable_merchant
		flash[:enabled] = "#{@merchant.name} is now disabled"
		redirect_to admin_merchants_path
	end
	
end
