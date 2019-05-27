class Admin::MerchantsController < ApplicationController
	def index
			@all_merchants = User.all_merchants
	end

	def show
		if current_admin?
			@merchant = User.find(params[:id])
		else 
			@merchant = User.find(params[:id])
			redirect_to dashboard_path 
		end
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
