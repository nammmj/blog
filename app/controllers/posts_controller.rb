class PostsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index]
	load_and_authorize_resource # Authenticate with Gem Cancan
	helper_method :sort_column, :sort_direction

	def index
  	@posts = Post.all.paginate(:page =>params[:page]).order(sort_column + ' ' + sort_direction)
  end
	def new
		@post = current_user.posts.new()
	end

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])	
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
		def post_params
			params.require(:post).permit(:title, :description, :content, :image, :active)			
		end
		def sort_column
			Post.column_names.include?(params[:sort]) ? params[:sort] : "created_at"			
		end
		def sort_direction
			%w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
		end
end
