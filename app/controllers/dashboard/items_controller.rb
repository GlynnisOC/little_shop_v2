class Dashboard::ItemsController < Dashboard::BaseController

	def index
	end

	def new
		@item = Item.new
	end

	def edit
		@item = Item.find(params[:id])
	end

end
