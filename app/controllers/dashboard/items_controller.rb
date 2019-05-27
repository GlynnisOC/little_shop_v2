class Dashboard::ItemsController < ApplicationController

	def index
	end

	def new
		@item = Item.new
	end

	def edit
		@item = Item.find(params[:id])
	end
	
end
