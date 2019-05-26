class Admin::UsersController < ApplicationController
		def index
			@all_reg_users = User.all_reg_users
		end

		def show
			@user = User.find(params[:id])
		end
		
		def upgrade
			if current_admin?
				user = User.find(params[:id])
				user.upgrade_to_merchant
				flash[:upgraded] = "#{user.name} is now a merchant"
				redirect_to admin_merchant_path(user)
			end
		end
end
