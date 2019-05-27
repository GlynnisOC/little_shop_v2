class Admin::MerchantsController < ApplicationController
	def index
		@all_merchants = User.all_merchants
	end

	def show
		@merchant = User.find(params[:id])
	end

	def enable
		@merchant = User.find(params[:id])
		@merchant.enable
		redirect_to admin_merchants_path
	end
end
