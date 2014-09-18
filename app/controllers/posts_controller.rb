class PostsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index]
	load_and_authorize_resource # Authenticate with Gem Cancan

	def index
		@search_value = params[:search][:search_value] if params[:search].present?

  	@posts = Post.search(@search_value).paginate(:page =>params[:page]).order(sort_column + ' ' + sort_direction)
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
		@comments = @post.comments.order(:created_at => :desc) if @post.comments.present?
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
end
		
