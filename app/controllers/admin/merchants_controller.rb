class Admin::MerchantsController < Admin::BaseController
	def index
			@all_merchants = User.all_merchants
	end

	def show
		if current_admin?
			@merchant = User.find(params[:id])
			redirect_to admin_user_path(@merchant) if @merchant.role == "default"
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

	def downgrade
		downgraded_merchant = User.find(params[:id])
		downgraded_merchant.item_disable
		downgraded_merchant.downgrade_to_user
		flash[:downgraded] = "#{downgraded_merchant.name} has been downgraded to a regular user"
		redirect_to admin_user_path(downgraded_merchant)
	end
end
