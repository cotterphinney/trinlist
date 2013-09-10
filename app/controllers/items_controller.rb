class ItemsController < ApplicationController
	before_filter :authenticate_user!, :only => :new

	def index
		@items = Item.all(:order => "created_at DESC")
	end

	def show
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		@item.user = current_user
		if @item.save
			flash[:success] = "Your item has been posted!"
			redirect_to items_path
		else
			render 'pages/index'
		end
	end

	def item_params
		params.require(:item).permit(:name, :description, :price)
	end
end
