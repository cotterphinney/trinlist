class ItemsController < ApplicationController
	before_filter :authenticate_user!, :only => :new

	def index
		if (params[:category] == "free")
			@items = Item.where("price == 0").order("created_at DESC")
		elsif params[:category]
			@items = Item.tagged_with(params[:category], :order => "created_at DESC")
		else
			@items = Item.all(:order => "created_at DESC")
		end
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
		@item.category_list = params[:categories]

		if @item.save
			flash[:notice] = "Your item has been posted"
			redirect_to root_path
		else
			render "new"
		end
	end

	def item_params
		params.require(:item).permit(:name, :description, :price)
	end
end
