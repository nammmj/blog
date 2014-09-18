class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]
	load_and_authorize_resource # Authenticate with Gem Cancan
	def index
		@users = User.all
	end
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(:role => "admin")
			redirect_to users_path
		else
			redirect_to users_path, notice: "Error can not active admin"
		end
	end
	def destroy
		@user = User.find(params[:id])
		if @user.role == "admin"
			flash[:error] = "You can not delete admin user"
			redirect_to users_path
		else
			@user.destroy
			redirect_to users_path
		end	
	end
	def show
		@user = User.find(params[:id])
		@posts = @user.posts.paginate(:page =>params[:page]).order(sort_column + ' ' + sort_direction)
		if @posts.blank?
			if @user == current_user
				flash[:notice] = "You have no post"
			else
				flash[:notice] = "This user has no post"
			end
			redirect_to root_url
		end
	end
end
