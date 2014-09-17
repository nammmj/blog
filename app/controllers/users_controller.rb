class UsersController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]

	def index
		@users = User.all
	end
	def destroy
		@user = User.find(params[:id])
		if @user.role == "admin"
			flash[:error] = "You can not delete admin user"
			redirect_to root_url
		else
			@user.destroy
			redirect_to root_url
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
