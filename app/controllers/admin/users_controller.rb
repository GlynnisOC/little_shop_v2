class Admin::UsersController < ApplicationController
		def index
			@all_reg_users = User.all_reg_users
		end

		def show
			@user = User.find(params[:id])
		end
end
