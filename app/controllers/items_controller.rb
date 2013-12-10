class ItemsController < ApplicationController
	before_filter :authenticate_user!, :only => [:new, :edit]

	def index
		if (params[:category] == "free")
			@items = Item.where("price = 0").order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
		elsif params[:category]
			@items = Item.tagged_with(params[:category], :order => "created_at DESC").paginate(:page => params[:page], :per_page => 15)
		else
			@items = Item.tagged_with("books", :order => "created_at DESC").paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
		end
	end

	def show
		@item = Item.find(params[:id])
		@seller = User.find(@item.user_id)
		@coop = User.find(22)
	end

	def my_listings
		@items = Item.where(user_id: current_user).paginate(:page => params[:page], :per_page => 15).order("created_at DESC")
	end

	def edit
		@item = Item.find(params[:id])
		unless (@item.user == current_user)
			flash[:alert] = "You don't have access there"
			redirect_to root_path
		end
	end

	def update
	  @item = Item.find(params[:id])
	  @item.category_list = params[:categories]
	 
	  if @item.update(item_params)
	  	flash[:notice] = "Your listing has been updated"
	    redirect_to @item
	  else
	    render 'edit'
	  end
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		@item.user = current_user
		@item.category_list = params[:categories]

		if @item.save
			flash[:notice] = "Your listing has been posted."
			redirect_to root_path
		else
			render "new"
		end
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy

		respond_to do |format| 
			format.html { redirect_to listings_path } 
			format.xml { head :ok } 
		end
  	end

  	private
		def item_params
			params.require(:item).permit(:name, :description, :location, :price, :image)
		end
end
